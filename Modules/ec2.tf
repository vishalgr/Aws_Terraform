provider "aws"{
 region = "${var.region}"
}

resource "aws_instance" "ec2_pro" {
    availability_zone = "${var.availability_zones}"
    ami ="${var.ami}"
    instance_type = "${var.instance_type}"
    key_name= "ControlServer"
    security_groups= ["${aws_security_group.ALLTRAFFIC.name}"]
    
}
resource "aws_security_group" "ALLTRAFFIC" {
    name="ALLTRAFFIC"

    ingress {
        from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

egress {
       from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]

}
 }

 resource "aws_ebs_volume" "volume1" {
    availability_zone = "us-west-2a"
    size = 1
    encrypted = true
  
}
resource "aws_volume_attachment" "ebsattchment" {
    device_name = "/dev/sdh"
    volume_id = "${aws_ebs_volume.volume1.id}"
    instance_id = "${aws_instance.ec2_pro.id}"
  
}
