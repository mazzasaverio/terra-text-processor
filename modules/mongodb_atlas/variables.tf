variable "mongo_atlas_org_id" {
  description = "Atlas Organization ID"
  type        = string
}

variable "mongo_atlas_project_name" {
  description = "Atlas Project Name"
  type        = string
}

variable "mongo_atlas_db_username" {
  type        = string
  description = "MongoDB Username"
}

variable "mongo_atlas_db_password" {
  type        = string
  description = "MongoDB Password"
}

variable "mongo_atlas_cidr_block" {
  description = "CIDR block for the Atlas network container"
  type        = string
}

variable "mongo_atlas_region" {
  description = "Atlas region where resources will be created"
  type        = string
}

variable "gcp_project_id" {
  description = "The GCP project ID."
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

# variable "region" {
#   description = "The GCP region"
#   type        = string
# }



# variable "gcp_network_name" {
#   description = "gcp_network_name"
#   type        = string
# }

# variable "google_vpc_self_link" {
#   description = "Self-link of the Google Cloud VPC"
#   type        = string
# }

# variable "mongo_atlas_cidr_block" {
#   description = "CIDR block for the Atlas network container"
#   type        = string
#   // Set a default value that fits your network plan or leave it without and define it in your terraform.tfvars file.
# }

