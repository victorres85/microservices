resource "aws_dynamodb_table" "answers" {
  name           = "Answers"
  hash_key       = "AnswerId"

  attribute {
    name = "AnswerId"
    type = "S"
  }

  attribute {
    name = "PlayerId"
    type = "S"
  }

  attribute {
    name = "StatementId"
    type = "S"
  }

  attribute {
    name = "score"
    type = "S"
  }

  attribute {
    name = "format"
    type = "S"
  }
  attribute {
    name = "fuged"
    type = "BOOL"
  }

  tags = {
    Name        = "dynamodb-answers-table"
    Environment = "production"
    Client = "felix"
    Project = "quiz"
  }
}
 