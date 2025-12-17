resource "aws_iam_role" "lambda_role" {
  name = "${var.lambda_name}_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = "sts:AssumeRole"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "basic_exec" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  output_path = "${path.module}/lambda.zip"

  source {
    filename = "index.mjs"
    content  = <<EOF
          export const handler = async (event) => {

            const body = JSON.parse(event.body || "{}");

            const first = body.firstName || "";
            const last  = body.lastName  || "";

            const responseBody = {
              message: `Hello from Lambda, $${first} $${last}`
            };

            return {
              statusCode: 200,
              headers: {
                "Access-Control-Allow-Origin": "*",
                "Access-Control-Allow-Headers": "*",
                "Access-Control-Allow-Methods": "OPTIONS,POST,GET"
              },
              body: JSON.stringify(responseBody)
            };
          };
EOF
  }
}

resource "aws_lambda_function" "function" {
  function_name = var.lambda_name
  handler       = "index.handler"
  runtime       = "nodejs24.x"

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  role = aws_iam_role.lambda_role.arn
}
