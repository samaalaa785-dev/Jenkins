output "public_instance_ids" {
  value = [
    aws_instance.public_a.id,
    aws_instance.public_b.id
  ]
}

output "private_instance_ids" {
  value = [
    aws_instance.private_a.id,
    aws_instance.private_b.id
  ]
}

output "public_instance_ips" {
  value = [
    aws_instance.public_a.public_ip,
    aws_instance.public_b.public_ip
  ]
}

output "public_alb_sg_id" {
  value = aws_security_group.public_alb.id
}

output "internal_alb_sg_id" {
  value = aws_security_group.internal_alb.id
}
