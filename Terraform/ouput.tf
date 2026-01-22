################################################################################
# 1. FRONTEND (S3)
################################################################################
output "frontend_url" {
  value = "http://${module.s3.endpoint_web}"
}

################################################################################
# 2. BACKEND (ALB)
################################################################################
output "alb_dns_name" {
  description = "DNS của Load Balancer (Dùng cái này làm URL gọi API từ Frontend)"
  value       = module.alb.dns_name
}

################################################################################
# 3. DATABASE & SECRETS
################################################################################
output "rds_endpoint" {
  description = "Địa chỉ kết nối của Database"
  value       = module.rds.mysql_address
}

output "secret_manager_name" {
  value       = module.rds.secret_manager_name
}

################################################################################
# 4. NETWORK & MONITORING
################################################################################
output "vpc_id" {
  value = module.network.vpc_id
}

output "nat_gateway_ips" {
  description = "IP tĩnh của các NAT Gateways"
  value       = [module.network.EIP_1, module.network.EIP_2]
}