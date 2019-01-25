provider "aws" {
  region = "${var.region}"
  profile = "${var.profile}"
}

# we need a service account user
resource "aws_iam_user" "user" {
  name = "${var.user_name}"
}

# generate keys for service account user
resource "aws_iam_access_key" "user_keys" {
  user = "${aws_iam_user.user.name}"
}
