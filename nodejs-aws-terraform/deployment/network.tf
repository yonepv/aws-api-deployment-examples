resource "aws_security_group" "security_group_nodejs_example_app" {
    name = "security_group_nodejs_example_app"
    description = "Allow TLS inbound traffic on port 80 (http)"
    #vpc_id = "${aws_vpc.vpc_example_app.id}"
    vpc_id = data.aws_vpc.selected.id

    ingress {
        from_port = 80
        to_port = 3000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

#vpc-link
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_integration
resource "aws_lb" "nodejs-example" {
    name = "nodejs-example"
    internal = true
    load_balancer_type = "network"
    subnets = [data.aws_subnet.public_a.id, data.aws_subnet.public_b.id]  
}

resource "aws_api_gateway_vpc_link" "nodejs-example" {
    name = "nodejs-example"
    target_arns = [aws_lb.nodejs-example.arn]
    #target_arns = [aws_lb.nlb.arn]
}

#from terraform docs
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api
resource "aws_api_gateway_rest_api" "nodejs-example" {
    name = "nodejs-example"  
}

resource "aws_api_gateway_resource" "nodejs-example" {
  #parent_id   = aws_api_gateway_rest_api.example.root_resource_id
  parent_id = aws_api_gateway_rest_api.nodejs-example.root_resource_id
  path_part   = "nodejs-example"
  rest_api_id = aws_api_gateway_rest_api.nodejs-example.id
}

resource "aws_api_gateway_method" "nodejs-example" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.nodejs-example.id
  rest_api_id   = aws_api_gateway_rest_api.nodejs-example.id
}

resource "aws_api_gateway_integration" "nodejs-example" {
  #http_method = aws_api_gateway_method.example.http_method
  http_method = aws_api_gateway_method.nodejs-example.http_method
  resource_id = aws_api_gateway_resource.nodejs-example.id   #example.id
  rest_api_id = aws_api_gateway_rest_api.nodejs-example.id  #example.id
  type        = "MOCK"
}

resource "aws_api_gateway_deployment" "nodejs-example" {
  rest_api_id = aws_api_gateway_rest_api.nodejs-example.id  #example.id

  triggers = {
    # NOTE: The configuration below will satisfy ordering considerations,
    #       but not pick up all future REST API changes. More advanced patterns
    #       are possible, such as using the filesha1() function against the
    #       Terraform configuration file(s) or removing the .id references to
    #       calculate a hash against whole resources. Be aware that using whole
    #       resources will show a difference after the initial implementation.
    #       It will stabilize to only change when resources change afterwards.
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.nodejs-example.id,  #example.id,
      aws_api_gateway_method.nodejs-example.id, #example.id,
      aws_api_gateway_integration.nodejs-example.id, #example.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "nodejs-example" {
  deployment_id = aws_api_gateway_deployment.nodejs-example.id #example.id
  rest_api_id   = aws_api_gateway_rest_api.nodejs-example.id #example.id
  stage_name    = "nodejs-example"
}