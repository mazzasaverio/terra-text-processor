# Project Overview

This repository contains Terraform configurations for processing unstructured data streams in a serverless and event-driven approach. The setup is designed to work with Google Cloud Platform (GCP), MongoDB Atlas, and Confluent Kafka through a peering connection.

Assuming data arrives in batches or continuously on Google storage, Pub/Sub triggers requests to a Cloud Run containing a script for text processing (see example repo [unstructed-process](https://github.com/mazzasaverio/unstructed-process)). The script extracts text, which is then stored in a MongoDB Atlas collection.

## Prerequisites

### Google Cloud

Before starting, ensure you have completed the following preliminary steps:

- Create a Google Cloud Platform account and set up a project.
- Create a service account (currently assumed to have Owner permissions).
  - Generate a key and store the .json file in a safe location.
- Enable the necessary APIs in your Google Cloud project:
  - Cloud Resource Manager API
  - Cloud Pub/Sub API
  - Cloud SQL Admin API
  - Google Container Registry API
  - Cloud Run API
  - Compute Engine API

### Confluent Kafka

- Navigate to the Cloud API keys section and generate a new API key.

### MongoDB Atlas

- **Account Creation**: Sign up for MongoDB Atlas if not already done and create an organization
- **API Key Generation**:
  - Navigate to `Organization settings`.
  - Select `Access Manager` and go to `API Keys`.
  - Click `Create API Key`, name it (e.g., "Terraform Integration"), and set appropriate permissions.
  - Securely note down the public and private keys.
- **Network Access Configuration**
  - On the same page, scroll down and click Add Access List Entry. If you are unsure of the IP address that you are running Terraform on (and you are performing this step from that machine), simply click Use Current IP Address and Save.

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
