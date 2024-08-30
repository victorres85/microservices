
resource "aws_dynamodb_table" "dichotomies" {
  name           = "Dichotomies"
  hash_key       = "DichotomyId"

  attribute {
    name = "DichotomyId"
    type = "S"
  }

  attribute {
    name = "preference_positive"
    type = "S"
  }

  attribute {
    name = "preference_positive_short"
    type = "S"
  }

  attribute {
    name = "preference_negative"
    type = "S"
  }

  attribute {
    name = "preference_negative_short"
    type = "S"
  }

  attribute {
    name = "custom_positive"
    type = "S"
  }

  attribute {
    name = "custom_negative"
    type = "S"
  }

  tags = {
    Name        = "dynamodb-dichotomies-table"
    Environment = "production"
    Client = "felix"
    Project = "quiz"
  }
}
