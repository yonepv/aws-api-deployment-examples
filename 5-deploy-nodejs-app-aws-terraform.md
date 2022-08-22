# Deploy NodeJs App on AWS Using Terraform and Docker

[original example](https://codelabs.transcend.io/codelabs/node-terraform/index.html?index=..%2F..index#0)

## Requisites
- node installed
- terraform installed
- docker installed
- awscli installed

| Tool  | Command  | Version |
|---|---|---|
| Node  | `node --version` | v10.9.0 |
| Terraform | `terraform --version` | Terraform v1.2.7 on linux_amd64 |
| Docker | `docker --version` | Docker version 20.10.17, build 100c701 |
| aws cli | `aws --version` | aws-cli/2.4.16 Python/3.8.8 Linux/5.15.0-43-generic exe/x86_64.ubuntu.20 prompt/off |

## [Create a basic NodeJS app](https://codelabs.transcend.io/codelabs/node-terraform/index.html?index=..%2F..index#1)

## [Make a Docker Image](https://codelabs.transcend.io/codelabs/node-terraform/index.html?index=..%2F..index#2)

### Running our image locally
- Build the image:
    ```bash
    docker build -t nodejs-aws-terraform .
    ```
- Run the container:
  ```bash
  docker run -p 12345:3000 -d nodejs-aws-terraform
  ```  
- Test it in the browser: [url](http://localhost:12345/)
  Result:
  Hello, World!

- Stop the container
  ```bash
  docker ps
  CONTAINER ID   IMAGE                  COMMAND                  CREATED         STATUS         PORTS                                         NAMES
    db06d092b5e9   nodejs-aws-terraform   "docker-entrypoint.s…"   5 minutes ago   Up 5 minutes   0.0.0.0:12345->3000/tcp, :::12345->3000/tcp   competent_gagarin
  ```
  ```bash
  docker stop competent_gagarin 
    competent_gagarin
  ```

### [Host your image on AWS ECR](https://codelabs.transcend.io/codelabs/node-terraform/index.html?index=..%2F..index#4)

Create folder deployment and create files:
- provider.tf -> to indicate the region and the profile to be used with the aws cli
- ecr.tf -> ecr repository for the example
