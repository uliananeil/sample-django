resource "aws_ecs_cluster" "aws-ecs-cluster" {
  name = var.cluster_name
}

resource "aws_ecs_task_definition" "aws-ecs-task" {
  family = "django-family"

  container_definitions = <<DEFINITION
  [
    {
      "name": "django-app",
      "image": "${var.ecr_repo}:latest",
      "entryPoint": [],
      "essential": true,
      "portMappings": [
        {
          "containerPort": 8000,
          "hostPort": 8000
        }
      ],
      "cpu": 1024,
      "memory": 2048,
      "networkMode": "awsvpc"
    }
  ]
  DEFINITION

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "2048"
  cpu                      = "1024"
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.ecsTaskExecutionRole.arn

}

data "aws_ecs_task_definition" "main" {
  task_definition = aws_ecs_task_definition.aws-ecs-task.family
}

resource "aws_ecs_service" "aws-ecs-service" {
  name                 = var.service_name
  cluster              = aws_ecs_cluster.aws-ecs-cluster.id
  task_definition      = aws_ecs_task_definition.aws-ecs-task.arn
  launch_type          = "FARGATE"
  scheduling_strategy  = "REPLICA"
  desired_count        = 2
  force_new_deployment = true

  network_configuration {
    subnets          = [aws_subnet.http-1.id, aws_subnet.http-2.id]
    assign_public_ip = true
    security_groups = [
      aws_security_group.service_sg.id,
      aws_security_group.lb-sg.id
    ]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = "django-app"
    container_port   = 8000
  }

  depends_on = [aws_lb_listener.listener]
}