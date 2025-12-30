resource "aws_key_pair" "wp_instance-key" {
  key_name   = "wp_instance-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILOAFO8AefSNTNtpui9DbesB+Mb+ZPkAYEXBBzEkL1b3 macbook@MuhdJamiu.local"
}