resource "aws_dynamodb_table" "players" {
  name           = "Players"
  hash_key       = "PlayerId"

  attribute {
    name = "PlayerId"
    type = "S"
  }

  attribute {
    name = "first_name"
    type = "S"
  }

  attribute {
    name = "second_name"
    type = "S"
  }

  attribute {
    name = "players_email"
    type = "S"
  }

  attribute {
    name = "cats_name"
    type = "S"
  }

  attribute {
    name = "cats_breed"
    type = "S"
  }

  attribute {
    name = "cats_age"
    type = "S"
  }

  attribute {
    name = "cats_color"
    type = "S"
  }

  attribute {
    name = "favourite_flavour"
    type = "S"
  }

  attribute {
    name = "treats_frequency"
    type = "S"
  }
  attribute {
    name = "purrsonality"
    type = "S"
  }

  attribute {
    name = "scores"
    type = "S"
  }

  attribute {
    name = "recommended_products"
    type = "S"
  }

  attribute {
    name = "cat_avatar"
    type = "S"
  }

  attribute {
    name = "cat_avatar_bespoke"
    type = "S"
  }

  attribute {
    name = "timestamp"
    type = "S"
  }

  attribute {
    name = "hash"
    type = "S"
  }

  attribute {
    name = "session"
    type = "S"
  }

  attribute {
    name = "opt_in"
    type = "S"
  }

  tags = {
    Name        = "dynamodb-players-table"
    Environment = "production"
    Client = "felix"
    Project = "quiz"
  }
}
