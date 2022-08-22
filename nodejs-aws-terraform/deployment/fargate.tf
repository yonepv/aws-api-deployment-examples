resource "aws_ecs_task_definition" "backend_task" {
    family = "backend_example_app_family"

    // Fargate is a type of ECS that requires awsvpc network_mode
    requires_compatibilities = ["FARGATE"]
    network_mode = "awsvpc"

    // Valid sizes are shown here: https://aws.amazon.com/fargate/pricing/
    memory = "512"
    cpu = "256"

    // Fargate requires task definitions to have an execution role ARN to support ECR images
    execution_role_arn = "${aws_iam_role.ecs_role.arn}"

    container_definitions = <<EOT
[
    {
        "name": "nodejs_example_app_container",
        "image": "698033540909.dkr.ecr.ca-central-1.amazonaws.com/ecr_demo_nodejs_repo:latest",
        "memory": 512,
        "essential": true,
        "portMappings": [
            {
                "containerPort": 3000,
                "hostPort": 3000
            }
        ]
    }
]
EOT
}

#ecs
resource "aws_ecs_cluster" "backend_cluster" {
    name = "backend_cluster_example_app"
}

resource "aws_ecs_service" "backend_service" {
    name = "backend_service"

    cluster = "${aws_ecs_cluster.backend_cluster.id}"
    task_definition = "${aws_ecs_task_definition.backend_task.arn}"

    launch_type = "FARGATE"
    desired_count = 1

    network_configuration {
        #subnets = ["${aws_subnet.public_a.id}", "${aws_subnet.public_b.id}"]
        subnets = ["${data.aws_subnet.public_a.id}", "${data.aws_subnet.public_b.id}"]
        security_groups = ["${aws_security_group.security_group_nodejs_example_app.id}"]
        #security_group_example_app.id}"]
        assign_public_ip = true
    }

    load_balancer {
      #target_group_arn = aws_lb.nlb.arn
      target_group_arn = aws_lb.nodejs-example.arn
      container_name = "nodejs_example_app_container"
      container_port = 3000
    }
}