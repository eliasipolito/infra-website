sudo su
yum update -y
yum stall -y docker
service docker start
usermod -a -G docker ec2-user
