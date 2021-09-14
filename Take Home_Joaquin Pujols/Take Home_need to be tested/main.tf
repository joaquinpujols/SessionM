 #--- FIRST WE DEFINE THE PROVIDER 
provider "aws" {
    region = "us-region-1"
  
}

resource "aws_instance" "web"{
    ami = "ami-0b0af3577fe5e3532"
    instance_type = "t2.micro"
    count = 2
    security_groups = [security_groups.nat]
    user_data = file("./script/volumes.sh")

    tags = {
        Name = "Web Server"
    }
}

