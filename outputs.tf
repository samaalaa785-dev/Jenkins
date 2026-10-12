output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_id" {
  value = aws_subnet.main.id
}

output "bucket_name" {
  value = aws_s3_bucket.main.bucket
}
