locals {
  ecr_name = {
    "redis"              = "${var.environment}-redis",
    "python"             = "${var.environment}-python",
    "java/discovery"     = "${var.environment}-java/discovery",
    "java/service"       = "${var.environment}-java/service",
    "python/application" = "${var.environment}-python/application"
  }
}
