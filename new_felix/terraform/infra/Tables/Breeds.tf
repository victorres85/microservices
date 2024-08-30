resource "aws_dynamodb_table" "breeds" {
  name           = "Breeds"
  hash_key       = "BreedId"

  attribute {
    name = "BreedId"
    type = "S"
  }

  attribute {
    name = "breed"
    type = "S"
  }

  tags = {
    Name        = "dynamodb-breeds-table"
    Environment = "production"
    Client = "felix"
    Project = "quiz"
  }
}
