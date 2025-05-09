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

variable "vlan_name" {
    type        = string
    default     = "vlan_network"
    description = "Name of VLAN"
}

variable "vlan_driver" {
    type        = string
    default     = "ipvlan"
    description = "Driver"
}

variable "subnet" {
    type        = string
    description = "LAN subnet"
}

variable "gateway" {
    type        = string
    description = "LAN gateway address"
}

variable "interface" {
    type        = string
    description = "LAN interface type"
}