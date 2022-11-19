terraform {
  backend "s3" {
    bucket         = "mybucketsuresh11"
    key            = "environment"
    region         = "us-west-2"
    dynamodb_table = "mydbsuresh"
  }
}