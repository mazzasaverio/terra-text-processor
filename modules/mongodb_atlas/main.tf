terraform {
  required_providers {
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
    }
  }
  required_version = ">= 0.13"
}

resource "mongodbatlas_project" "project" {
  org_id = var.mongo_atlas_org_id
  name   = var.mongo_atlas_project_name
}

# Create a Database User
resource "mongodbatlas_database_user" "db-user" {
  username           = var.mongo_atlas_db_username
  password           = var.mongo_atlas_db_password
  project_id         = mongodbatlas_project.project.id
  auth_database_name = "admin"
  roles {
    role_name     = "readWrite"
    database_name = "${var.mongo_atlas_project_name}-db"
  }
}

# IP access list entry for GCP auto-mode network CIDR
resource "mongodbatlas_project_ip_access_list" "gcp_access_list" {
  project_id = mongodbatlas_project.project.id
  cidr_block = "10.128.0.0/9" # GCP auto-mode network range
  comment    = "GCP network CIDR block"
}

/* -------------------------------------------------------------------------- */
/*                           GCP peering connection                           */
/* -------------------------------------------------------------------------- */

resource "mongodbatlas_network_container" "network_container" {
  project_id       = mongodbatlas_project.project.id
  atlas_cidr_block = var.mongo_atlas_cidr_block // This must be a unique CIDR block and not overlap with other network resources
  provider_name    = "GCP"
}

resource "mongodbatlas_network_peering" "peering" {
  project_id     = mongodbatlas_project.project.id
  container_id   = mongodbatlas_network_container.network_container.container_id
  provider_name  = "GCP"
  gcp_project_id = var.gcp_project_id
  network_name   = "default"
}

data "google_compute_network" "default" {
  name = "default"
}

resource "google_compute_network_peering" "peering" {
  name         = "gc-to-atlas-peering"
  network      = data.google_compute_network.default.self_link
  peer_network = "https://www.googleapis.com/compute/v1/projects/${mongodbatlas_network_peering.peering.atlas_gcp_project_id}/global/networks/${mongodbatlas_network_peering.peering.atlas_vpc_name}"
}



# # Create Database IP Access List 
# resource "mongodbatlas_project_ip_access_list" "ip" {
#   project_id = mongodbatlas_project.project.id
#   ip_address = var.mongo_atlas_cidr_block
# }








# # Existing IP access list entry for your personal IP
# resource "mongodbatlas_project_ip_access_list" "my_access_list" {
#   project_id = mongodbatlas_project.project.id
#   cidr_block = var.my_ip_cidr_block
#   comment    = "Personal Terraform IP access list entry"
# }



resource "mongodbatlas_cluster" "cluster" {
  project_id = mongodbatlas_project.project.id
  name       = "Cluster0"
  num_shards = 1

  cluster_type = "REPLICASET"

  replication_specs {
    num_shards = 1
    regions_config {
      region_name     = var.mongo_atlas_region
      electable_nodes = 3
      priority        = 7
      read_only_nodes = 0
    }
  }


  provider_name = "GCP"

  provider_instance_size_name = var.mongo_cluster_instance_size_name

  lifecycle {
    prevent_destroy = false
  }

  depends_on = [google_compute_network_peering.peering]

}

