output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnet_ids" {
  value = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.network.private_subnet_ids
}

output "bucket_name" {
  value = aws_s3_bucket.main.bucket
}

output "public_instance_ids" {
  value = module.ec2.public_instance_ids
}

output "private_instance_ids" {
  value = module.ec2.private_instance_ids
}
