resource "kind_cluster" "default" {
    name = var.cluster_name

    kind_config {
        kind        = "Cluster"
        api_version = "kind.x-k8s.io/v1alpha4"

        dynamic "node" {
            for_each = range(var.master_count)
            content {
                role = "control-plane"
            }
        }
        
        dynamic "node" {
            for_each = range(var.worker_count)
            iterator
            content {
                role = "worker-${count.index}"
            }
        }
    }
}