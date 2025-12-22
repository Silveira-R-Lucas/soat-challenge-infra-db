variables {
  aws_region     = "sa-east-1"
  db_password    = "senha_longa_e_segura_123"
  mongo_username = "admin"
  mongo_password = "mongo_senha_segura_123"
}

# Teste 1: Validar se o RDS está configurado como privado
run "verify_rds_privacy" {
  command = plan

  assert {
    condition     = aws_db_instance.soat_db.publicly_accessible == false
    error_message = "O banco de dados RDS não deve ser acessível publicamente."
  }

  assert {
    condition     = aws_db_instance.soat_db.engine == "postgres"
    error_message = "O motor do banco de dados deve ser postgres."
  }
}

# Teste 2: Validar se as regras de Security Group estão corretas
run "verify_security_groups" {
  command = plan

  assert {
    condition     = aws_security_group.rds.ingress[0].from_port == 5432
    error_message = "A porta de entrada do RDS deve ser 5432."
  }

  assert {
    condition     = aws_security_group.mongo_sg.ingress[0].from_port == 27017
    error_message = "A porta de entrada do MongoDB deve ser 27017."
  }
}

# Teste 3: Validar os Outputs sensíveis
run "verify_sensitive_outputs" {
  command = plan

  assert {
    condition     = output.db_password != null
    error_message = "O output da senha do banco de dados deve ser gerado."
  }
}