resource "aws_route53_record" "blue" {
  zone_id = aws_route53_zone.private_dns.id
  name    = "blue-green"
  type    = "CNAME"
  ttl     = "5"

  weighted_routing_policy {
    weight = 2
  }

  set_identifier = "blue"
  records        = [kubernetes_service.blue.status.0.load_balancer.0.ingress.0.hostname] # https://github.com/hashicorp/terraform-provider-kubernetes/pull/1125
}

resource "aws_route53_zone" "private_dns" {
  name    = "udacityexercise"
  comment = "DNS for Udacity Projects"

  vpc {
    vpc_id = module.vpc.vpc_id
  }
}