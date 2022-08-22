variable "namespace" {
  description = "The project namespace to use for unique resource naming"
  type        = string
  default = "Dev"
}
 
variable "ssh_keypair" {
  description = "SSH keypair to use for EC2 instance"
  default     = null
  type        = string
}
 
variable "aws_region" {
  description = "AWS region"
  default     = "ca-central-1"
  type        = string
}