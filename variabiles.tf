
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

variable "gcp_network_name" {
  description = "The name of the VPC network in GCP."
  type        = string
}


# ------------------------------- MONGODB ATLAS ------------------------------- #

variable "mongo_atlas_org_id" {
  type        = string
  description = "Atlas Organization ID"
}

variable "mongo_atlas_project_name" {
  type        = string
  description = "Atlas Project Name"
}


variable "mongo_atlas_public_key" {
  description = "Public key for MongoDB Atlas"
  type        = string
}

variable "mongo_atlas_private_key" {
  description = "Private key for MongoDB Atlas"
  type        = string
  sensitive   = true
}



variable "mongo_atlas_db_username" {
  description = "MongoDB Username"
  type        = string
}

variable "mongo_atlas_db_password" {
  description = "MongoDB Password"
  type        = string
  sensitive   = true
}


variable "mongo_atlas_cidr_block" {
  description = "CIDR block for the Atlas network container"
  type        = string
}


variable "mongo_atlas_region" {
  description = "Atlas region where resources will be created"
  type        = string
}


variable "mongo_cluster_instance_size_name" {
  description = "Cluster instance size name"
  type        = string
  default     = "M0" # Free tier size
}

# variable "my_ip_cidr_block" {
#   description = "CIDR block for the Terraform machine to allow in the MongoDB Atlas project IP access list"
#   type        = string
# }
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


variable "confluent_kafka_topic" {
  description = "The name of the Kafka topic"
  type        = string
}
