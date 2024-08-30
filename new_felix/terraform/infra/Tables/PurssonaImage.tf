resource "aws_dynamodb_table" "purrsonasImage" {
  name           = "PurrsonasImage"
  hash_key       = "PurrsonasImageId"

  attribute {
    name = "PurrsonasImageId"
    type = "S"
  }

  attribute {
    name = "bg_layer"
    type = "S"
  }
  attribute {
    name = "top_layer"
    type = "S"
  }
  attribute {
    name = "beige"
    type = "S"
  }
  attribute {
    name = "black"
    type = "S"
  }
  attribute {
    name = "black_white"
    type = "S"
  }
  attribute {
    name = "brown"
    type = "S"
  }
  attribute {
    name = "mixed"
    type = "S"
  }
  attribute {
    name = "ginger"
    type = "S"
  }
  attribute {
    name = "grey"
    type = "S"
  }
  attribute {
    name = "hairless"
    type = "S"
  }
  attribute {
    name = "tabby"
    type = "S"
  }
  attribute {
    name = "white"
    type = "S"
  }

  tags = {
    Name        = "dynamodb-purrsonas-image-table"
    Environment = "production"
    Client = "felix"
    Project = "quiz"
  }
}
