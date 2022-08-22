data "aws_vpc" "selected" {
    tags = {
      "Name" = "${var.namespace}_vpc"
    }  
}

data "aws_subnet" "public_a" {
    vpc_id = data.aws_vpc.selected.id
    availability_zone = "${var.aws_region}a"
    tags = {
      "Name" = "Web_${var.namespace}_aza_net"
    }
}

data "aws_subnet" "public_b" {
    vpc_id = data.aws_vpc.selected.id
    availability_zone = "${var.aws_region}b"
    tags = {
      "Name" = "Web_${var.namespace}_azb_net"
    }
}