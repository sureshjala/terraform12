variable "region" {
    type = string
    default = "us-west-2"
  
}
variable "cidr_block" {
    type = string
    default = "10.10.0.0/16"
  
}
variable "availability_zone" {
    type = string
    default = "us-west-2a"
    
}
variable "cidr_block_subnet" {
    type = string
    default = "10.10.0.0/24"
  
}
variable "my_server-trigger" {
    type = string
    description = "giving the trigger to the null resource"
    default = "1.0"
}
variable "instance_name" {
    type = list(string)
    default = [ "my_server1", "my_server2" ]
  
}