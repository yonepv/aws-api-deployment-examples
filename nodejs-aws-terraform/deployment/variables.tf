variable "aws_region" {
    default = "ca-central-1"
}
variable "aws_application" {
  type = string
  description = "The application's name."
  sensitive = false
  default = "nodejs-example"
}

variable "aws_environment" {
  type = string
  description = "The deployment environment (dev, prod). Default = \"dev\"."
  sensitive = false
  default = "dev"
}

/*
variable "aws_region" {
  type = string
  description = "The AWS region where resources are created."
  sensitive = false
}

variable "aws_compte_number" {
  type        = number
  description = "The number of the compte aws "
  sensitive   = false
}

variable "aws_ecs_secret_app_arn" {
  type        = string
  description = "ARN of the application secret."
  sensitive   = false
}

variable "aws_route53_zone_id" {
  type        = string
  description = ""
  sensitive   = false
}

variable "aws_nlb_vpc_id" {
  type = string
  description = "Identifier of the VPC in which to create the target group."
  sensitive = false
}

variable "aws_nlb_web_subnets_id" {
  type        = list(string)
  description = "A list of subnet IDs to attach to the LB. "
  sensitive = false
}

variable "aws_alb_arn" {
  type = string
  description = "Identifier of the arn alb target group"
  sensitive = false
}

variable "aws_nlb_health_check_path" {
  type        = string
  description = "Destination for the health check request."
  sensitive   = false
}

variable "aws_nlb_tg_port" {
  type = number
  description = "Port of the target group to expose on the service ecs"
  sensitive = false
}

variable "gateway_secret" {
  type        = string
  description = "gateway_secret."
  sensitive   = false
}

variable "aws_ecs_ec2_alb_tg_port" {
  type        = number
  description = "Port of the target group to expose on the service ecs."
  sensitive   = false
}

variable "sso_jwt_audience" {
  type = string
  description = "The client id of openid"
  sensitive = true
}
variable "sso_jwt_issuer" {
  type = string
  description = "The endpoint of issuer"
  sensitive = false
}
variable "sso_jwt_certs_path" {
  type = string
  description = "The path of the certificate endpoint that returns the public keys enabled by the realm"
  sensitive = false
}*/
