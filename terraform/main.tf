# Create a S3 Bucket
resource "aws_s3_bucket" "index" {
  bucket = "${var.bucket-1}"
  acl = "public-read"
  policy = <<POLICY
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"AddPermission",
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::${var.bucket-1}/*"]
    }
  ]
}
POLICY
  website {
      index_document = "index.html"
      error_document = "error.html"
  }
}