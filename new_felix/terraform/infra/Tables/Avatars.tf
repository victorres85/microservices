resource "aws_dynamodb_table" "avatars" {
  name           = "Avatars"
  hash_key       = "AvatarId"

  attribute {
    name = "AvatarId"
    type = "S"
  }

  attribute {
    name = "family"
    type = "S"
  }

  attribute {
    name = "priority"
    type = "N"
  }

  attribute {
    name = "PlayerId"
    type = "S"
  }

  attribute {
    name = "filename"
    type = "S"
  }

  tags = {
    Name        = "dynamodb-avatars-table"
    Environment = "production"
    Client = "felix"
    Project = "quiz"
  }
}
 