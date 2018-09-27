
resource "aws_s3_bucket_object" "file_1" {
  bucket = "${aws_s3_bucket.index.bucket}"
  key = "content/css/main-app.css"
  source = "../content/css/main-app.css"
}

resource "aws_s3_bucket_object" "file_2" {
  bucket = "${aws_s3_bucket.index.bucket}"
  key = "content/html/index.html"
  source = "../content/html/index.html"
}
