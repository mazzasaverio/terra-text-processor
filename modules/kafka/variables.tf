

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

variable "gcp_region" {
  description = "The GCP region."
}

variable "gcp_project_id" {
  description = "The GCP project ID."
}

variable "gcp_network_name" {
  description = "The name of the VPC network in GCP."
}



# variable "atlas_cidr_block" {
#   description = "CIDR block for the Atlas network container."
# }

# variable "kafka_server_endpoint" {
#   description = "The Kafka server endpoint for the consumer."
#   type        = string
# }
# variable "confluent_kafka_topic" {
#   description = "The name of the Kafka topic"
#   type        = string
# }
# variable "storage_bucket_name" {
#   description = "The name of the GCS bucket"
#   type        = string
# }


# # Google Cloud Credentials File
# variable "google_credentials_file" {
#   description = "The path to the Google Cloud credentials file."
#   type        = string
# }


