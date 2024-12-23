resource "aws_security_group" "ssh_access" {
  name        = "ssh-access"
  description = "Allow SSH inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress = [
    {
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]

      description     = ""
      from_port       = 22
      prefix_list_ids = []
      protocol        = "tcp"
      security_groups = []
      self            = false
      to_port         = 22
    },
  ]

  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]

      description     = ""
      from_port       = 80
      to_port         = 80
      prefix_list_ids = []
      protocol        = "tcp"
      security_groups = []
      self            = false
    },
  ]

  tags = {
    Name = "ssh_access"
  }
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "curl-instance"

  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ssh_access.id]
  subnet_id              = module.vpc.public_subnet_ids[0]
}