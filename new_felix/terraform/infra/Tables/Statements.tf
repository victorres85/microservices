
resource "aws_dynamodb_table" "statements" {
  name           = "Statements"
  hash_key       = "StatementId"

  attribute {
    name = "StatementId"
    type = "S"
  }

  attribute {
    name = "is_active"
    type = "BOOL"
  }

  attribute {
    name = "id_dichotomy"
    type = "S"
  }

  attribute {
    name = "format"
    type = "S"
  }

  attribute {
    name = "question"
    type = "S"
  }

  attribute {
    name = "end_positive"
    type = "S"
  }

  attribute {
    name = "end_negative"
    type = "S"
  }

  attribute {
    name = "scenario"
    type = "S"
  }

  tags = {
    Name        = "dynamodb-statements-table"
    Environment = "production"
  }
}
