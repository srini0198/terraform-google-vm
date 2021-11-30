// required variables
variable "name" {
  type        = string
  description = "this name will be used as prefix for all the resources in the module"
}

variable "zone" {
  type        = string
  description = "this is the location where the vm will be created"
}

variable "network" {
  type        = string
  description = "this is the vpc for the vm"
}

variable "machine_type" {
  type        = string
  description = "this is the machine type for the vm"
}

variable "project_id" {
  type        = string
  description = "this is the project id in which the vm is created"
}

variable "boot_disk_image" {
  description = "The source image to build the VM's boot disk from."
  type        = string
}

// optional variables
variable "service_account_id" {
  type        = string
  description = "the id is used as a postfix in service account created."
}

variable "boot_disk_size" {
  description = "The size of the boot disk in GigaBytes. Must be at least the size of the boot disk image."
  type        = number
}

variable "boot_disk_type" {
  description = "The disk type. May be set to \"pd-standard\", \"pd-balanced\" or \"pd-ssd\"."
  type        = string
}

