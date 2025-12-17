# AWS Website und Lambda über Terraform bereitstellen

Dieses Projekt erstellt eine AWS-Infrastruktur für das Hosten einer statischen Website und die 
Bereitstellung einer Lambda-Funktion, die über API Gateway aufgerufen werden kann.

## Voraussetzungen

- Terraform ≥ 1.5
- AWS Account
- AWS CLI v2 (konfiguriert mit einem IAM-User mit ausreichend Berechtigungen)

## Projektstruktur

- **modules/:** alle Terraform-Module (S3, CloudFront, Lambda, API-Gateway).
- **frontend/:** `index.html` als Beispiel Website (API-URL muss noch ergänzt werden).
- **terraform.tfvars**: Vorlage mit Beispiel Variablen (ggf. ändern).

## Vorgehensweise

### 1. Repo klonen
```bash
git clone https://github.com/HoffmannEduard/iu-terraform-project
```
```bash 
cd iu-terraform-project
```

### 2. Terraform initialisieren
```bash
terraform init
```
### 3. Plan prüfen 
```bash
terraform plan
```
Ggf. Variablen in terraform.tfvars anpassen

### 4. Infrastruktur anwenden
```bash
terraform apply
```
Mit `yes` bestätigen.

### 5. API-URL übernehmen und Website hochladen
- Terraform liefert die `API-URL` als Output
- API-URL in `frontend/index.html`eintragen
```javascript
var awsURL = "<API-Gateway-URL>"; // <<<----- Hier URL einfügen
```
- Speichern und anschließend `index.html` in den von Terraform erstellten S3-Bucket hochladen.

### 6. Testen

- Terraform liefert die `CloudFront-URL` als Output
- Website über die CloudFront-URL im Browser aufrufen.
- Testwerte eingeben, Call API klicken, Ausgabe prüfen
  
Hinweis: Die Lambda-Funktion ist so konfiguriert, dass CORS-Anfragen korrekt verarbeitet werden.

### 7. Aufräumen
- `index.html` aus dem S3-Bucket löschen
```bash
terraform destroy
```
- Mit `yes` bestätigen. Ressourcen werden gelöscht.
