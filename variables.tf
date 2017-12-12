variable "region" {
	description = "Default region for ecs"
	default = "us-east-1"
}

variable "ami" {
	description = "Default ami based on region"
	type = "map"
	default = {
		us-east-1 = "ami-fad25980"
		us-east-2 = "ami-58f5db3d"
	}
}

variable "cluster_name" {
	type = "string"
	default = "knowbe4-dev"
}

variable "instance_type" {
	description = "the instance type"
	default = "t2.micro"
}


