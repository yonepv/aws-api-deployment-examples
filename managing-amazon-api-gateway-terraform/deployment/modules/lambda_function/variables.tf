variable "s3_bucket_name" {
  type        = string
  description = "The name of the S3 bucket to store the Lambda function code"
  #default     = "terraform-api-gateway-lambda-demo" // must be unique - change this to something unique
  default = "rp-terraform-api-gateway-lambda-demo"
}

variable "lambda_function_name" {
  type        = string
  description = "The name of the Lambda function"
  default     = "MovieLambda"
}