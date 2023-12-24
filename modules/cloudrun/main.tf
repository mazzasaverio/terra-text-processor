resource "google_cloud_run_service" "text_extract" {
  name     = "text-extract-v1"
  location = var.gcp_region

  template {
    spec {
      containers {
        image = var.gcp_text_extraction_image

        resources {
          limits = {
            memory = "1024Mi"
          }
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  metadata {
    annotations = {
      "run.googleapis.com/ingress" = "all"
    }
  }
}


resource "google_cloud_run_service_iam_member" "text_extraction_invoker" {
  service  = google_cloud_run_service.text_extract.name
  location = var.gcp_region
  role     = "roles/run.invoker"
  member   = "serviceAccount:${var.gcp_service_account_email}"
}
