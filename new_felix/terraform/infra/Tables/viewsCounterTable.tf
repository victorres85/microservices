resource "aws_dynamodb_table" "ViewsCounterTable" {
  name           = "ViewsCounter"
  hash_key       = "Id"
  range_key      = "TimeStamp"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "timestamp"
    type = "S"
  }
  attribute {
    name = "home_viewers"
    type = "N"
  }
  attribute {
    name = "form_viewers"
    type = "N"
  }
  attribute {
    name = "quiz_viewers"
    type = "N"
  }
  attribute {
    name = "result_viewers"
    type = "N"
  }
  attribute {
    name = "upload_cat_viewers"
    type = "N"
  }
  tags = {
    Name        = "dynamodb-views-counter-table"
    Environment = "production"
    Client = "felix"
    Project = "quiz"
  }
}