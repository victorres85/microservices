resource "aws_dynamodb_table" "purrsonas" {
  name           = "Purrsonas"
  hash_key       = "PurrsonasId"

  attribute {
    name = "PurrsonasId"
    type = "S"
  }

  attribute {
    name = "family"
    type = "S"
  }
  attribute {
    name = "title"
    type = "S"
  }
  attribute {
    name = "description"
    type = "S"
  }
  attribute {
    name = "short"
    type = "S"
  }
  attribute {
    name = "MM1_code"
    type = "S"
  }
  attribute {
    name = "MM2_code"
    type = "S"
  }
  attribute {
    name = "complementary_code"
    type = "S"
  }
  attribute {
    name = "bundle_code"
    type = "S"
  }

  tags = {
    Name        = "dynamodb-purrsonas-table"
    Environment = "production"
    Client = "felix"
    Project = "quiz"
  }
}
