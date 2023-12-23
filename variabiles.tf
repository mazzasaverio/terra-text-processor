
# ------------------------------- GOOGLE CLOUD ------------------------------- #

variable "google_credentials_file" {
  description = "The path to the Google Cloud credentials file."
  type        = string
}

variable "gcp_project_id" {
  description = "The GCP project ID."
  type        = string
}

variable "region" {
  description = "The GCP region."
  type        = string
}

variable "zone" {
  description = "The GCP zone."
  type        = string
}

variable "gcp_bucket_name" {
  description = "Name of the GCP bucket"
  type        = string
}

variable "service_account_email" {
  description = "Service account email to invoke the Cloud Run service"
  type        = string
}


# ------------------------------- MONGODB ATLAS ------------------------------- #


variable "mongodb_atlas_public_key" {
  description = "Public key for MongoDB Atlas"
  type        = string
}

variable "mongodb_atlas_private_key" {
  description = "Private key for MongoDB Atlas"
  type        = string
  sensitive   = true
}


# Atlas Organization ID 
variable "atlas_org_id" {
  type        = string
  description = "Atlas Organization ID"
}

# Atlas Project Name
variable "atlas_project_name" {
  type        = string
  description = "Atlas Project Name"
}
