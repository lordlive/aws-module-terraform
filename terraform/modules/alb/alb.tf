module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = var.app_name

  load_balancer_type         = "application"
  enable_deletion_protection = false

  vpc_id          = var.vpc_id
  subnets         = var.subnets
  security_groups = var.security_groups

  # Port configuration for the ALB (in previous config)
  # target_groups = [
  #   {
  #     name             = "eks-nodes"
  #     backend_protocol = "HTTPS"
  #     backend_port     = 32000
  #     target_type      = "instance"
  #   }
  # ]

  # target_groups = [
  #   {
  #     name             = "eks-auth-tg"
  #     backend_protocol = "HTTP"
  #     backend_port     = 80
  #     target_type      = "ip"

  #     tags = {
  #       "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  #     }

  #   }
  # ]

  target_groups = []

  https_listeners = [
    {
      port            = 443
      certificate_arn = var.certificate_arn #aws_acm_certificate.test_cert.arn
      ssl_policy      = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
    }
  ]

  # https_listener_rules = [
  #   {
  #     https_listener_index = 0
  #     priority             = 1000

  #     actions = [{
  #       type               = "forward"
  #       target_group_index = 0
  #     }]

  #     conditions = [{
  #       path_patterns = ["/auth", "/auth/*"]
  #     }]
  #   }
  # ]
  https_listener_rules = []

  tags = {
    "ingress.k8s.aws/resourcegroup" = "my-apps" # deps
  }

}

# Create autoscaling attachment to target groups
# resource "aws_autoscaling_attachment" "asg_attachment_keycloak" {
#   autoscaling_group_name = var.eks_asg_name
#   lb_target_group_arn   = module.alb.target_group_arns[0]
# }


# Port configuration for the ALB (in previous config)
# resource "aws_autoscaling_attachment" "asg_attachment_nodes" {
#   autoscaling_group_name = var.eks_asg_name
#   lb_target_group_arn    = module.alb.target_group_arns[0]
# }



/* module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "deps-alb"

  load_balancer_type         = "application"
  enable_deletion_protection = false

  vpc_id          = var.vpc_id
  subnets         = var.subnets
  security_groups = var.security_groups

  target_groups = [
    {
      name             = "deps-eks-nodes"
      backend_protocol = "HTTP"
      backend_port     = 32000
      target_type      = "instance"
    }
  ]

  http_tcp_listeners = [
    {
      port               = 8080
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]
}

resource "aws_autoscaling_attachment" "asg_attachment_nodes" {
  autoscaling_group_name = var.eks_asg_name
  alb_target_group_arn   = module.alb.target_group_arns[0]
} */
