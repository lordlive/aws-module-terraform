resource "aws_iam_policy" "aws_lb_controller" {
  name        = "AWSLoadBalancerControllerIAMPolicy-${var.env}"
  description = "Policy for AWS Load Balancer Controller operation in EKS"

  policy = file("${path.module}/iam_policy.json")
}

resource "aws_iam_role" "aws_lb_controller" {
  name = "EKS-AWS-Load-Balancer-Controller-${var.env}-Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "pods.eks.amazonaws.com"
        }
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "aws_lb_controller_attach" {
  role       = aws_iam_role.aws_lb_controller.name
  policy_arn = aws_iam_policy.aws_lb_controller.arn
}

resource "aws_eks_pod_identity_association" "aws_lb_controller" {
  cluster_name    = var.cluster_name
  namespace       = "kube-system"
  service_account = "aws-load-balancer-controller"
  role_arn        = aws_iam_role.aws_lb_controller.arn

  tags = {
    Environment = var.env
    Purpose     = "load-balancer-controller"
  }

}

resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"

  # The controller will start to behave ONLY after the Pod Identity association is ready
  depends_on = [aws_eks_pod_identity_association.aws_lb_controller]

  values = [
    jsonencode({
      clusterName = var.cluster_name
      region      = var.region
      vpcId       = var.vpc_id

      serviceAccount = {
        create = true
        name   = "aws-load-balancer-controller"
      }
    })
  ]
}
