resource "kind_cluster" "default" {
    name           = var.cluster_name

    kind_config {
        kind        = "Cluster"
        api_version = "kind.x-k8s.io/v1alpha4"

        dynamic "node" {
            for_each = range(var.master_count)
            content {
                role = "control-plane"
                extra_port_mappings (
                    container_port  = 80
                    host_port       = 80
                )
            }
        }
        
        dynamic "node" {
            for_each = range(var.worker_count)
            content {
                role = "worker"
            }
        }

        # networking {
        #     disable_default_cni = true
        #     pod_subnet          = "192.168.0.0/16"
        # }
    }
}

# resource "docker_network" "private_network" {
#     name    =   var.vlan_name
#     driver  =   var.vlan_driver

#     ipam_config {
#         subnet  = var.subnet
#         gateway = var.gateway
#     }

#     options = {
#         parent  = var.interface
#     }
# }

# resource "null_resource" "connect_kind_nodes" {
#     depends_on  = [kind_cluster.default, docker_network.private_network]

#     provisioner "local-exec" {
#         command = <<EOT
#             for node in $(docker ps --filter "name=${var.cluster_name}" --format "{{.Names}}"); do
#               docker network connect ${var.vlan_name} $node
#             done
#         EOT
#     }
# }