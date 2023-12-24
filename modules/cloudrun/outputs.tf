output "service_url" {
  value       = google_cloud_run_service.text_extract.status[0].url
  description = "The URL of the Cloud Run service"
}

