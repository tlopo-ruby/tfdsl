terraform {
    backend "local" {
        path = "relative/path/to/terraform.tfstate"
    }
}

variable "images"  {
    default = {
        us-east-1 = "ami-123456"
        us-east-2 = "ami-654321"
    }
    type = "map"
}

variable "foo"  {
}

data "aws_ami" "ami" {
    most_recent = "true"
    owners = [
        "amazon"
    ]
    filter  {
        name = "name"
        values = [
            "Windows_Server-2016-English-Full-Base-*"
        ]
    }
    filter  {
        name = "virtualization-type"
        values = [
            "hvm"
        ]
    }
}

resource "null_resource" "foo" {
    triggers  {
        foo = "bar"
    }
    provisioner "local-exec" {
        command = "whoami"
    }
}

module "some_module"  {
    list_of_objects = [
        {
            foo = "bar"
            bar = "foo"
        },
        {
            foo1 = "bar1"
            bar1 = "foo1"
        },
        "somevalue",
        "another value"
    ]
}

resource "local_file" "foo" {
    content = "{\n    \"key1\" : \"value\",\n    \"ke2\": 1\n}\n"
    filename = "/tmp/foo"
}

resource "local_file" "bar" {
    content = "bar"
    filename = "/tmp/bar"
}