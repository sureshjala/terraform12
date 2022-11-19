resource "aws_instance" "my_server" {
    count = terraform.workspace == "qa" ? 2:0
    subnet_id = aws_subnet.subnet.id
    vpc_security_group_ids = [ aws_security_group.my_sg.id ]
    instance_type = "t2.micro"
    key_name = "id_rsa"
    ami = "ami-017fecd1353bcc96e"
    associate_public_ip_address = true
    tags = {
      "Name" = var.instance_name
    }
  
}
resource "null_resource" "provisoner" {
  triggers = {
    running_number = var.my_server-trigger
  }
  provisioner "remote-exec" {

      connection {
      type = "ssh"  
      user = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      port = 22
      host = aws_instance.my_server[0].public_ip
    }
# installing angular application in ec2 instance
    inline = [
    "git clone https://github.com/sureshjala/angular-realworld-example-app.git",
    "cd angular-realworld-example-app",
    "curl -s https://deb.nodesource.com/setup_16.x | sudo bash",
    "sudo apt install nodejs -y",
    "sudo npm install -g @angular/cli",
    "npm install",
    "ng serve --host 0.0.0.0 &"
    ]
  

  }
    depends_on = [
    aws_instance.my_server
    ]

}