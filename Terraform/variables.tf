variable "region" {
    type = string
    description = "The AWS region to deploy resources"
}
variable "access_key" {
    type = string
}
variable "secret_key" {
    type = string
}
variable "cidr_block" {}
variable "cidr_block_public_1" {}
variable "cidr_block_private_1" {}
variable "cidr_block_public_2" {}
variable "cidr_block_private_2" {}
variable "zone_1" {}
variable "zone_2" {}
variable "uname" {}
variable "pass" {
  sensitive = true
}