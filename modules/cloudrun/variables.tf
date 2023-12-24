

variable "gcp_text_extraction_image" {
  description = "The image for the text extraction Cloud Run service"
  type        = string
}


variable "gcp_service_account_email" {
  description = "Service account email to invoke the Cloud Run service"
  type        = string
}

variable "gcp_region" {
  description = "The GCP region."
  type        = string
}
variable "gcp_project_id" {
  description = "The GCP project ID."
}
