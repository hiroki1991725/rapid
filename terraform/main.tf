# Create a S3 Bucket with Web site hosting
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
      routing_rules = <<REDIRECTIONRULES
[{
  "Condition":{
    "KeyPrefixEquals" : "index.html"
  },
  "Redirect":{
    "ReplacePlefixWith" : "content/html/index.html"
  },
  "Condition":{
    "KeyPrefixEquals" : "error.html"
  },
  "Redirect":{
    "ReplacePlefixWith" : "content/html/error.html"
  }
}]
REDIRECTIONRULES
  }
}

# Create Route53 settings
resource "aws_route53_zone" "main" {
  name="hello.test"
}

resource "aws_route53_record" "rapid" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name = "rapid.hello.test"
  type ="CNAME"
  ttl = "3600"
  records = ["${aws_s3_bucket.index.website_endpoint}"]
}

# Upload Contents to bucket
### -> By default, terraform cannnot upload FOLDERs to S3.
### -> So,Using "Make-UploadFilestf.py" and "UploadingFiles.tf" make it done.

