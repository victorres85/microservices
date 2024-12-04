module "aws-prod" {
  source = "./infra"
  instancia = "t4g.xlarge"
  ami_id = "ami-025db40ba9581d621"
  aws_region = "eu-west-2"
  chave = "IaC-Production"
  desired_capacity = 0
  min_size = 0
  max_size = 0
  groupName = "IaC-Prod"
  sec_group_name = "alb_full_access"
  AWS_ACCESS_KEY = "AKI...M6S"
  AWS_SECRET_KEY = "Fgns9...x8C4Fx9hs"
  BUCKET_NAME = "felix-quiz-1000heads"
  AWS_REGION = "eu-west-2"
  DB_HOST = "localhost"
  DB_NAME = "felixdb"
  DB_USER = "felixuser"
  DB_PASS = "Mv...q6"
  DB_PORT=5432
  DJANGO_ENV = "prod"
  DJANGO_SECRET_KEY = "aQo7+m02...m^ap1b"
  DEFAULT_FILE_STORAGE = "storages.backends.s3boto3.S3Boto3Storage"
  BG_REMOVAL_ALLOWED = "1"
  DJANGO_SETTINGS_MODULE = "settings.settings_prod"
  AWS_STORAGE_BUCKET_NAME = "felix-quiz-1000heads"
}


# ami-0d8f6eb4f641ef691
# r6g.large
# c6g.large  2	4 GiB	Up to 10 Gigabit	EBS only	0.0808
# c6a.large	2	4 GiB	Up to 12500 Megabit	EBS only	0.0909
# t4g.xlarge 4 16 GiB Up to 5 Gigabit EBS only 0.1504 -> 2 machines with 2 workers each support up to 30 users with no issues 
# t4g.xlarge 4 16 GiB Up to 5 Gigabit EBS only 0.1504 -> 2 machines with 3 workers each support up to 30 users with no issues 
# t4g.xlarge 4 16 GiB Up to 5 Gigabit EBS only 0.1504 -> 2 machines with 4 workers each support up to 50 users with no issues 


# ami-0505148b3591e4c07
# c5a.large   2cpu  ram   4GiB  $0.09 per Hour  can have 2
# t3a.large   2cpu  ram   8GiB  $0.085 per Hour  can have 2
# m5.large    2cpu  ram   8GiB  $0.111 per Hour  can have 2
# r5a.large   2cpu  ram  16GiB  $0.133 per Hour  can have 1
# c6a.xlarge   4cpu  ram   8GiB  $0.164 per Hour can have 1
# c5.xlarge   4cpu  ram   8GiB  $0.200 per Hour can have 1

