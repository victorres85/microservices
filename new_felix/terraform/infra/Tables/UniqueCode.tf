resource "aws_dynamodb_table" "uniqueCode" {
  name           = "UniqueCodes"
  hash_key       = "UniqueCodeId"

  attribute {
    name = "UniqueCodeId"
    type = "S"
  }

  attribute {
    name = "code"
    type = "S"
  }

  attribute {
    name = "is_used"
    type = "BOOL"
  }

  attribute {
    name = "timestamp"
    type = "S"
  }
  
  tags = {
    Name        = "dynamodb-uniqueCode-table"
    Environment = "production"
    Client = "felix"
    Project = "quiz"
  }
}
 