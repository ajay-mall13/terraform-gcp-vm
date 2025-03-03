variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The region where resources will be created"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The zone for the VM"
  type        = string
  default     = "us-central1-a"
}

variable "vm_name" {
  description = "The name of the VM instance"
  type        = string
  default     = "terraform-vm"
}

variable "machine_type" {
  description = "The machine type for the VM"
  type        = string
  default     = "e2-medium"
}

variable "image" {
  description = "The OS image for the VM"
  type        = string
  default     = "debian-cloud/debian-11"
}
