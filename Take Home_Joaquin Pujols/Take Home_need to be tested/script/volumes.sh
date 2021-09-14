 
#!/bin/bash
df -TH >> ~/free_space.txt
sudo vgcreate LVMGrpServices /dev/sdb /dev/sdc
sudo lvcreate -L 100GB -n lv_services LVMGrpServices
sudo lvcreate -L 50GB -n lv_logs LVMGrpServices
#This will create the logical volumes but no mount on fstab file yet



#Installing apache
sudo yum -y update && yum -y install httpd
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<h1>Welcome to Apache JP</h1>" | sudo tee /var/www/html/index.html