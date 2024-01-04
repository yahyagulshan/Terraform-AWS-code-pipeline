############################################
##  Common Variables
############################################
variable "region" {
  description = "AWS Region for this stack"
  type        = string
  default     = "us-east-1"
}

variable "stack_name" {
  description = "Stack Name (ie: Prod1, CS1P, QA01, DepTest03, etc.)"
  type        = string
}

variable "environment" {
  description = "Environment identifier for VPC and TGW Name tags"
  type        = string
}

variable "company" {
  type        = string
  description = "Company identifier to use for naming"
}

############################################
##  Tag Variables
############################################

variable "common_tags" {
  description = "Tags that should be applied to all tagable resources"
  type        = map(any)
  default     = {}
}

variable "application" {
  description = "Value to apply to the Application tag on all tagable resources"
  type        = string
}

variable "owner" {
  description = "The owner of this resource (Requester/Department/Responsible Party)"
  type        = string
}

variable "purpose" {
  description = "Why is this resource being created?"
  type        = string
}
# End standard tag values

############################################
##  AWS VPC Variables
############################################