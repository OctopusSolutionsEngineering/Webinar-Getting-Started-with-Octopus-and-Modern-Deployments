variable "apiKey" {
  type = string
}

variable "space" {
  type = string
}

variable "serverURL" {
  type = string
}

variable "projectGroupName" {
  type = string
}

variable "projectGroupDescription" {
  type = string
}

variable "environments" {
  type = list(any)
}

variable "internalClient" {
  type = string
}
