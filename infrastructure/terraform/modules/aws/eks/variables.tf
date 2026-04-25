variable "cluster_name" {
  description = "EKS cluster name."
  type        = string
}

variable "kubernetes_version" {
  description = "EKS Kubernetes version. Leave null to use the AWS default for the selected region."
  type        = string
  default     = null
}

variable "vpc_cidr" {
  description = "CIDR block for the EKS VPC."
  type        = string
  default     = "10.60.0.0/16"
}

variable "availability_zones" {
  description = "Explicit availability zones. When empty, the module uses availability_zone_count zones from the selected region."
  type        = list(string)
  default     = []
}

variable "availability_zone_count" {
  description = "Number of availability zones to use when availability_zones is empty."
  type        = number
  default     = 2

  validation {
    condition     = var.availability_zone_count >= 2
    error_message = "EKS requires at least two availability zones."
  }
}

variable "create_private_subnets" {
  description = "Whether to create private subnets. Public subnets are always created for load balancers and low-cost public-node clusters."
  type        = bool
  default     = false
}

variable "enable_nat_gateway" {
  description = "Whether to create a NAT gateway for private subnet egress."
  type        = bool
  default     = false
}

variable "map_public_ip_on_launch" {
  description = "Whether public subnets assign public IPs to launched instances. Required for public managed node groups."
  type        = bool
  default     = true
}

variable "node_subnet_type" {
  description = "Subnet type for the default managed node group."
  type        = string
  default     = "public"

  validation {
    condition     = contains(["public", "private"], var.node_subnet_type)
    error_message = "node_subnet_type must be either public or private."
  }
}

variable "endpoint_private_access" {
  description = "Whether the EKS API endpoint is reachable from inside the VPC."
  type        = bool
  default     = false
}

variable "endpoint_public_access" {
  description = "Whether the EKS API endpoint is reachable publicly."
  type        = bool
  default     = true
}

variable "public_access_cidrs" {
  description = "CIDRs allowed to reach the public EKS API endpoint."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "authentication_mode" {
  description = "EKS access management authentication mode."
  type        = string
  default     = "API_AND_CONFIG_MAP"
}

variable "bootstrap_cluster_creator_admin_permissions" {
  description = "Whether the cluster creator receives admin permissions through EKS access management."
  type        = bool
  default     = true
}

variable "node_instance_types" {
  description = "EC2 instance types for the default managed node group."
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_capacity_type" {
  description = "Capacity type for the default managed node group."
  type        = string
  default     = "SPOT"

  validation {
    condition     = contains(["ON_DEMAND", "SPOT"], var.node_capacity_type)
    error_message = "node_capacity_type must be ON_DEMAND or SPOT."
  }
}

variable "node_ami_type" {
  description = "AMI type for the default managed node group."
  type        = string
  default     = "AL2023_x86_64_STANDARD"
}

variable "node_disk_size" {
  description = "Root disk size in GiB for default node group instances."
  type        = number
  default     = 20
}

variable "node_min_size" {
  description = "Minimum size for the default node group."
  type        = number
  default     = 1
}

variable "node_desired_size" {
  description = "Desired size for the default node group."
  type        = number
  default     = 1
}

variable "node_max_size" {
  description = "Maximum size for the default node group."
  type        = number
  default     = 1
}

variable "node_labels" {
  description = "Kubernetes labels applied to default node group nodes."
  type        = map(string)
  default     = {}
}

variable "enable_ebs_csi_driver" {
  description = "Whether to install the AWS EBS CSI driver EKS add-on."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags applied to all supported AWS resources."
  type        = map(string)
  default     = {}
}
