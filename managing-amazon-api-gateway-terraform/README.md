# MANAGING AMAZON API GATEWAY USING TERRAFORM

[url](https://hands-on.cloud/managing-amazon-api-gateway-using-terraform/)

api_gateway         OK
lambda_function

| Module  | Status | Comments |
|---|---|---|
| api_gateway  | OK  |   |
| lambda_function  | OK  | Only problems with cloudwatch logs  |

## Errors

### CloudWatch

```bash
module.lambda_function.aws_lambda_function.lambda_function: Creation complete after 6s [id=MovieLambda]
module.lambda_function.aws_cloudwatch_log_group.lambda_log_group: Creating...
╷
│ Error: AccessDeniedException: User: arn:aws:sts::131485263174:assumed-role/AWSReservedSSO_AWSAdministratorAccess_8897fc41610db419/roccio.philippsvalencia@mcn.gouv.qc.ca is not authorized to perform: logs:PutRetentionPolicy on resource: arn:aws:logs:ca-central-1:131485263174:log-group:/aws/lambda/MovieLambda:log-stream: with an explicit deny in a service control policy
│ 	status code: 400, request id: 4e5d0c61-c481-40b1-998b-9470b61048d4
│ 
│   with module.lambda_function.aws_cloudwatch_log_group.lambda_log_group,
│   on modules/lambda_function/lambda.tf line 35, in resource "aws_cloudwatch_log_group" "lambda_log_group":
│   35: resource "aws_cloudwatch_log_group" "lambda_log_group" {
```

### Invoke

```bash
rocio@cqen-rp:~/dev/cqen/tickets/ceai/ceai-128-example-deployment-api-aws/managing-amazon-api-gateway-terraform/deployment$ aws lambda invoke --function-name MovieLambda response.json

An error occurred (UnrecognizedClientException) when calling the Invoke operation: The security token included in the request is invalid.
rocio@cqen-rp:~/dev/cqen/tickets/ceai/ceai-128-example-deployment-api-aws/managing-amazon-api-gateway-terraform/deployment$ aws lambda invoke --profile dev_ceai_aws15  --function-name MovieLambda response.json
{
    "StatusCode": 200,
    "ExecutedVersion": "$LATEST"
}
```


