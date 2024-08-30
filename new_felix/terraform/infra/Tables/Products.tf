resource "aws_dynamodb_table" "products" {
  name           = "Products"
  hash_key       = "ProductId"

  attribute {
    name = "ProductId"
    type = "S"
  }

  attribute {
    name = "category"
    type = "S"
  }

  attribute {
    name = "category_code"
    type = "S"
  }

  attribute {
    name = "product_code"
    type = "S"
  }

  attribute {
    name = "product"
    type = "S"
  }

  attribute {
    name = "flavour"
    type = "S"
  }

  attribute {
    name = "age"
    type = "S"
  }

  attribute {
    name = "image"
    type = "S"
  }

  attribute {
    name = "url"
    type = "S"
  }

  attribute {
    name = "is_active"
    type = "BOOL"
  }

  attribute {
    name = "timestamp"
    type = "S"
  }

  tags = {
    Name        = "dynamodb-products-table"
    Environment = "production"
    Client = "felix"
    Project = "quiz"
  }
}
