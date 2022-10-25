#this file is for configurating the provider and giving it region and so on
provider "aws" {

}

#gets configuration from variables

data "aws_availability_zones" "available" {

}
