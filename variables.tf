variable "repository_name" {
  type        = string
  description = "The name of your GIT repository"
}

variable "default_branch" {
  type        = string
  description = "The name of the default repository branch"
  default     = "master"
}

variable "developer_group" {
  description = "An existing Iam Group to attach the policy permissions to"
  type        = string
  default     = ""
}

variable "kms_master_key_id" {
  type        = string
  description = "The kms key to use"
  default     = "alias/aws/sns"
}
