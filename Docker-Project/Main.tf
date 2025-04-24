terraform {
  required_providers {
    docker= {
        source = "kreuzwerker/docker"
        version = "3.3.0"
    }
  }
}

provider "docker" { }

resource "docker_image" "nginx_image" {

    name = "${var.image_name}:${var.image_tag}"
 }

 resource "docker_container" "nginx_container" {
    name = "Web-Server"
        image = docker_image.nginx_image.image_id

    ports {
            internal = var.internal_port
            external = var.external_port
    }
   
 }

variable "image_name" {
  type = string
  description = "This is the name of my docker image"
  default = "nginx"
}
variable "image_tag" {
  type = string
  description = "This is the tag of my docker image"
  default = "1.23.3"
}
variable "internal_port" {
  type = number
  description = "This is the internal port"
}
variable "external_port" {
  type = number
  description = "This is the external port"
}