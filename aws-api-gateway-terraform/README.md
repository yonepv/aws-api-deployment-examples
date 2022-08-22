# AWS API Gateway with Terraform

[url](https://medium.com/onfido-tech/aws-api-gateway-with-terraform-7a2bebe8b68f)

A simple api gateway.

It does not work because of "invalid function argument"

```bash
    │ Error: Invalid function argument
    │ 
    │   on api.tf line 36, in resource "aws_api_gateway_domain_name" "domain":
    │   36:   certificate_body = "${file("${path.module}/example.com/example.crt")}"
    │     ├────────────────
    │     │ path.module is "."
    │ 
    │ Invalid value for "path" parameter: no file exists at "./example.com/example.crt"; this function works only with files that are
    │ distributed as part of the configuration source code, so if this file will be created by a resource in this configuration you must
    │ instead obtain this result from an attribute of that resource.
    ╵
    ╷
    │ Error: Invalid function argument
    │ 
    │   on api.tf line 37, in resource "aws_api_gateway_domain_name" "domain":
    │   37:   certificate_chain = "${file("${path.module}/example.com/ca.crt")}"
    │     ├────────────────
    │     │ path.module is "."
    │ 
    │ Invalid value for "path" parameter: no file exists at "./example.com/ca.crt"; this function works only with files that are
    │ distributed as part of the configuration source code, so if this file will be created by a resource in this configuration you must
    │ instead obtain this result from an attribute of that resource.
    ╵
    ╷
    │ Error: Invalid function argument
    │ 
    │   on api.tf line 38, in resource "aws_api_gateway_domain_name" "domain":
    │   38:   certificate_private_key = "${file("${path.module}/example.com/example.key")}"  
    │     ├────────────────
    │     │ path.module is "."
    │ 
    │ Invalid value for "path" parameter: no file exists at "./example.com/example.key"; this function works only with files that are
    │ distributed as part of the configuration source code, so if this file will be created by a resource in this configuration you must
    │ instead obtain this result from an attribute of that resource.

```