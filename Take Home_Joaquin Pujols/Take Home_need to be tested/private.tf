 /*
  Compute Internal Hosts (No NAT)
*/
resource "aws_security_group" "internal" {
    name = "vpc_commute"
    description = "Allow internal compute ."

    ingress { # Web
        from_port = 443
        to_port = 443
        protocol = "tcp"
        security_groups = ["${aws_security_group.web.id}"]
    }
    ingress { # SSH
        from_port = 22
        to_port = 22
        protocol = "tcp"
        security_groups = ["${aws_security_group.web.id}"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.vpc_cidr}"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["${var.vpc_cidr}"]
    }

    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.default.id}"

    tags {
        Name = "Internal Hosts"
    }
}

resource "aws_instance" "internal-2" {
    ami = "${lookup(var.amis, var.aws_region)}"
    availability_zone = "us-east-1"
    instance_type = "t2.micro"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.db.id}"]
    subnet_id = "${aws_subnet.eu-west-1a-private.id}"
    source_dest_check = false

    tags {
        Name = "Internal-2"
    }
}

