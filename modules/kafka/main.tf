terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.56.0"
    }

  }
  required_version = ">= 0.13"
}

provider "confluent" {
  cloud_api_key    = var.confluent_cloud_api_key
  cloud_api_secret = var.confluent_cloud_api_secret
}

resource "confluent_environment" "development" {
  display_name = var.confluent_environment_name
}

resource "confluent_kafka_cluster" "basic" {
  display_name = var.confluent_cluster_name
  availability = var.confluent_availability
  cloud        = var.confluent_cloud
  region       = var.gcp_region
  basic {}

  environment {
    id = confluent_environment.development.id
  }
}





# resource "confluent_service_account" "app-manager" {
#   display_name = "app-manager"
#   description  = "Service account to manage Kafka cluster"

# }


# resource "confluent_role_binding" "app-manager-kafka-cluster-admin" {
#   principal   = "User:${confluent_service_account.app-manager.id}"
#   role_name   = "CloudClusterAdmin"
#   crn_pattern = confluent_kafka_cluster.basic.rbac_crn
# }


# resource "confluent_api_key" "app-manager-kafka-api-key" {
#   display_name = "app-manager-kafka-api-key"
#   description  = "Kafka API Key that is owned by 'app-manager' service account"
#   owner {
#     id          = confluent_service_account.app-manager.id
#     api_version = confluent_service_account.app-manager.api_version
#     kind        = confluent_service_account.app-manager.kind
#   }

#   managed_resource {
#     id          = confluent_kafka_cluster.basic.id
#     api_version = confluent_kafka_cluster.basic.api_version
#     kind        = confluent_kafka_cluster.basic.kind

#     environment {
#       id = confluent_environment.development.id
#     }
#   }


# }



# resource "confluent_network" "peering" {
#   display_name     = "GCP Peering Network"
#   cloud            = "GCP"
#   region           = var.region
#   cidr             = "10.10.0.0/16" # Using the Atlas CIDR block variable
#   connection_types = ["PEERING"]
#   environment {
#     id = confluent_environment.development.id
#   }


# }

# resource "confluent_peering" "gcp" {
#   display_name = "GCP Peering"
#   gcp {
#     project     = var.gcp_project_id
#     vpc_network = var.gcp_network_name

#   }
#   environment {
#     id = confluent_environment.development.id
#   }
#   network {
#     id = confluent_network.peering.id
#   }


# }

# resource "google_compute_network_peering" "peering" {
#   name         = "gc-to-confluent-peering"
#   network      = "projects/${var.gcp_project_id}/global/networks/${var.gcp_network_name}"
#   peer_network = "projects/${confluent_network.peering.gcp[0].project}/global/networks/${confluent_network.peering.gcp[0].vpc_network}"
# }



# resource "confluent_kafka_topic" "pdf_upload_topic" {

#   kafka_cluster {
#     id = confluent_kafka_cluster.basic.id
#   }
#   topic_name    = var.confluent_kafka_topic
#   rest_endpoint = confluent_kafka_cluster.basic.rest_endpoint
#   credentials {
#     key    = confluent_api_key.app-manager-kafka-api-key.id
#     secret = confluent_api_key.app-manager-kafka-api-key.secret
#   }

# }





# resource "confluent_connector" "gcs_source" {
#   environment {
#     id = confluent_environment.development.id
#   }
#   kafka_cluster {
#     id = confluent_kafka_cluster.basic.id
#   }

#   config_nonsensitive = {
#     "connector.class"          = "GcsSource"
#     "name"                     = "GcsSourceConnector_0"
#     "kafka.auth.mode"          = "SERVICE_ACCOUNT"
#     "kafka.service.account.id" = confluent_service_account.app-manager.id
#     "topic.regex.list"         = "${var.confluent_kafka_topic}:.*\\.pdf"
#     "gcs.bucket.name"          = var.storage_bucket_name
#     "tasks.max"                = "1"
#     "input.data.format"        = "JSON"
#     "output.data.format"       = "JSON"

#     // Additional configuration options can be added here
#   }

#   config_sensitive = {
#     "kafka.api.key"        = var.confluent_cloud_api_key
#     "kafka.api.secret"     = var.confluent_cloud_api_secret
#     "gcs.credentials.json" = file(var.google_credentials_file)
#   }

#   depends_on = [
#     // Dependencies on other resources can be added here
#   ]


# }
