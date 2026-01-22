variable "db_class" {}
variable "db_subnet_1" {}
variable "db_subnet_2" {}
variable "db_uname" {}
variable "db_pass" {
  sensitive = true
}
variable "sg_db_id" {}
