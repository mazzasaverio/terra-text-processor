output "kafka_bootstrap_servers" {
  value       = confluent_kafka_cluster.basic.rest_endpoint
  description = "REST endpoint of the Kafka cluster"
}
