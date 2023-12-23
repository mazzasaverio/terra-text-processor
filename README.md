# esg-x-terraform

## Overview

Questa repository contiene la configurazione terraform utile per poter processare un flusso di dati non strutturati in un ottiva serveless ed event driven. In particolare è impostata la configurazione per poter utilizzare gcp, mongodb atlas e confluent kafka tramite connessione peering

Supponendo che i dati arrivano in batch o in modo continuo sullo storage di google, tramite pubsub vengono inviate richieste a una cloud run che deve contenere l'immagine di uno script che processa il testo (come esempio vedi la repo [unstructed-process](https://github.com/mazzasaverio/unstructed-process))

Viene quindi eseguita l'estrazione del testo, e il testo estratto viene storicizzato su una collection di mongodb atlas

## Prerequisites

### Google Cloud

Before you begin, assicurati di aver eseguito questi step preliminari:

- Crea un account google cloud platform e crea un progetto
- Crea un service account (at the moment I consider it with Owner permits)

  - Create a key and save the .json in the home (to be understood later where to put this key).

- Necessary APIs enabled in your Google Cloud project:

  - Cloud Resource Manager API
  - Cloud Pub/Sub API
  - Cloud SQL Admin API
  - Google Container Registry API
  - Cloud Run API
  - MongoDB Atlas (crea un organizzazione)
    - Crea l'API Key come organization owner (da rivedere in futuro)

### MongoDB Atlas

To configure your MongoDB Atlas environment, follow these steps:

1. **MongoDB Atlas Account Configuration**:

   - Ensure you have an active MongoDB Atlas account.
   - Generate public and private API keys in your MongoDB Atlas account.
   - Crea un organizzazione

2. **Permission Assignment**:

   - Assign 'Organization Project Creator' permissions to the appropriate user.
     - _Note: Further exploration is needed to understand the correct implementation of this permission setting._

3. **API Key Access List Configuration**:
   - Navigate to the API Key Access List section in your MongoDB Atlas account.
   - Scroll down and select 'Add Access List Entry'.
   - If you are unsure of the IP address from which you are running Terraform (especially if it's from the same machine), use the 'Use Current IP' option for convenience.

## Configuration

Rename the `terraform.tfvars.example` file to `terraform.tfvars` and fill in the variables as required.

## Terraform Code Alignment and Indentation in VS Code

To ensure proper formatting of Terraform code in Visual Studio Code, perform the following steps:

- Install Prettier and the HashiCorp Terraform extension in VS Code.
- Optionally, modify your `settings.json` in VS Code to include:
  ```json
  "[terraform]": {
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "hashicorp.terraform",
    "editor.tabSize": 2
  },
  "[terraform-vars]": {
    "editor.tabSize": 2
  }
  ```

## Notes

- It takes about ten minutes to complete all the provisioning (currently, setting up the databases is the most time-consuming part).
- At the moment it is necessary to manually assign specific permits to storage and subscription
- also on Mongo you have to assign specific permits to be able to make them create the collections

## Useful Links

[Deploy MongoDB Atlas on AWS with Terraform](https://www.mongodb.com/developer/products/atlas/deploy-mongodb-atlas-terraform-aws/)

[Medium:extracting-text-from-pdf-files-with-python ](https://towardsdatascience.com/extracting-text-from-pdf-files-with-python-a-comprehensive-guide-9fc4003d517)

[How to Deploy MongoDB Atlas on GCP using Terraform](https://gmusumeci.medium.com/how-to-deploy-mongodb-atlas-on-gcp-using-terraform-3c88127c00d0)

## Main Terraform Commands and Best Practices

- **Initialize a Terraform working directory**:
  ```bash
  terraform init
  ```
- **Create an execution plan**:
  ```bash
  terraform plan
  ```
- **Apply the changes required to reach the desired state of the configuration**:
  ```bash
  terraform apply
  ```
- **Destroy the Terraform-managed infrastructure**:
  ```bash
  terraform destroy
  ```

Best Practices:

- Regularly use `terraform fmt` to format code for consistency.
- Store sensitive information in secure and encrypted data sources.
- Regularly review and apply Terraform version updates.

## Building and Pushing a Docker Image to Google Container Registry

To build and push a Docker image to Google Container Registry, follow these commands (replace `esg-x-v2` and `hello` with your project and image names):

```bash
docker build -t gcr.io/esg-x-v2/hello:latest .
docker push gcr.io/esg-x-v2/hello:latest
```
