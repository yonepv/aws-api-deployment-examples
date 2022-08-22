data "aws_vpc" "selected" {
    tags = {
      "Name" = "Dev_vpc"
    }  
}

data "aws_subnet" "public_a" {
    vpc_id = data.aws_vpc.selected.id
    availability_zone = "${var.aws_region}a"
    tags = {
      "Name" = "Web_Dev_aza_net"
    }
}

data "aws_subnet" "public_b" {
    vpc_id = data.aws_vpc.selected.id
    availability_zone = "${var.aws_region}b"
    tags = {
      "Name" = "Web_Dev_azb_net"
    }
}