output "vpc_id" {
  description = "vpc_id"
  value       = aws_vpc.vpc.id
}

output "private_subnet1_id" {
  description = "private subnet 1 id"
  value       = aws_subnet.private_subnet1.id
}

output "private_subnet2_id" {
  description = "private subnet 2 id"
  value       = aws_subnet.private_subnet2.id
}

output "public_subnet1_id" {
  description = "public subnet 1 id"
  value       = aws_subnet.public_subnet1.id
}

output "public_subnet2_id" {
  description = "public subnet 2 id"
  value       = aws_subnet.public_subnet2.id
}