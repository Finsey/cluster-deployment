variable "cluster_name" {
    type        = string
    default     = "home-cluster"
    description = "Name of the KinD cluster"
}

variable "master_count" {
    type        = number
    default     = 1
    description = "Number of master nodes"
}

variable "worker_count" {
    type        = number
    default     = 2
    description = "Number of worker nodes"
}