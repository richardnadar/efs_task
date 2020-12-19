# Provisioning instance
resource "aws_instance" "webServerOS" {
  ami           = "ami-09a7bbd08886aafdf"
  instance_type = "t2.micro"
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.efs_firewall.id]

  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("C:/Users/ilann/Downloads/hadoopkey.pem")
    host     = aws_instance.webServerOS.public_ip
  }
 
  provisioner "remote-exec" {
    inline = [
      "sudo yum install amazon-efs-utils httpd php git -y",
      "sudo systemctl restart httpd",
      "sudo systemctl enable httpd",
      "sudo setenforce 0",
      "sudo yum install nfs-utils -y",
      "sudo mount -t efs ${aws_efs_file_system.efs_storage.id}:/ /var/www/html",
      "sudo echo ${aws_efs_file_system.efs_storage.id}:/ /var/www/html efs defaults_netdev 0 0 >> sudo /etc/fstab",
      "sudo rm -f /var/www/html/",
      "sudo git clone https://github.com/ther1chie/efs-task.git /var/www/html/",

    ]
  }

  tags = {
    Name = "myefsos"
  }

}

output "webServerIP" {
  value = aws_instance.webServerOS.public_ip
}
