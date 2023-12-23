
# ------------------------------- GOOGLE CLOUD ------------------------------- #

variable "gcp_credentials_file" {
  description = "The path to the Google Cloud credentials file."
  type        = string
}

variable "gcp_project_id" {
  description = "The GCP project ID."
  type        = string
}

variable "gcp_region" {
  description = "The GCP region."
  type        = string
}

variable "gcp_zone" {
  description = "The GCP zone."
  type        = string
}

variable "gcp_bucket_name" {
  description = "Name of the GCP bucket"
  type        = string
}

variable "gcp_service_account_email" {
  description = "Service account email to invoke the Cloud Run service"
  type        = string
}


# ------------------------------- MONGODB ATLAS ------------------------------- #

variable "mongo_atlas_public_key" {
  description = "Public key for MongoDB Atlas"
  type        = string
}

variable "mongo_atlas_private_key" {
  description = "Private key for MongoDB Atlas"
  type        = string
  sensitive   = true
}

variable "mongo_atlas_org_id" {
  type        = string
  description = "Atlas Organization ID"
}

variable "mongo_atlas_project_name" {
  type        = string
  description = "Atlas Project Name"
}

# ------------------------------- CONFLUENT CLOUD ---------------------------- #




variable "confluent_cloud_api_key" {
  description = "API Key for Confluent Cloud"
  type        = string
}

variable "confluent_cloud_api_secret" {
  description = "API Secret for Confluent Cloud"
  type        = string
}

variable "confluent_environment_name" {
  description = "The name of the Confluent Cloud environment"
  type        = string
}

variable "confluent_cluster_name" {
  description = "The name of the Confluent Cloud environment"
  type        = string
}

variable "confluent_availability" {
  description = "The name of the Confluent Cloud environment"
  type        = string
}

variable "confluent_cloud" {
  description = "The name of the Confluent Cloud environment"
  type        = string
}


