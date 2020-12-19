#EFS creation
resource "aws_efs_file_system" "efs_storage" {
	creation_token = "EFS for Backup"
	performance_mode = "generalPurpose"
     	throughput_mode = "bursting"
	encrypted = "true"
	tags = {
		Name = "External Storage" 
	}
    
    
}


#mounting EFS
resource "aws_efs_mount_target" "efs1" {
	file_system_id = "${aws_efs_file_system.efs_storage.id}"
    subnet_id = "subnet-f05e5e98"
	security_groups = ["${aws_security_group.efs_firewall.id}"]


    depends_on = [
    aws_efs_file_system.efs_storage,
  ]
}