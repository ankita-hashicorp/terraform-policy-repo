policytest {
  targets = ["simple_test.policy.hcl"]
}

resource "aws_instance" "example" {
  ami                         = "ami-12345678"
  instance_type               = "t3.micro"
  availability_zone           = "eu-north-1a"
  subnet_id                   = "subnet-0123456789abcdef0"
  vpc_security_group_ids      = ["sg-0123456789abcdef0"]
  key_name                    = "example-key"
  iam_instance_profile        = "example-instance-profile"
  associate_public_ip_address = true
  monitoring                  = false
  source_dest_check           = true

  root_block_device {
    volume_size = 8
    volume_type = "gp2"
    encrypted   = true
  }

  ebs_block_device {
    device_name           = "/dev/sdh"
    volume_size           = 20
    delete_on_termination = true
  }

  tags = {
    Name        = "example-instance"
    Environment = "dev"
    Owner       = "team-a"
  }
}

