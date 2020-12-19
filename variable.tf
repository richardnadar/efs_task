variable "access_key" {
    type = string
    default = "your_access_key"
}
variable "secret_key" {
    type = string
    default = "your_secret_key"
}


# Entering private key for authentication
variable "key_name" {
    type = string
    description = "Key Name For Instance"
    // default = "hadoopkey"
}