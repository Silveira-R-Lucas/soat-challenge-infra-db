# SOAT - Infraestrutura do Banco de Dados (infra-db)

Este repositório é dedicado exclusivamente ao gerenciamento da infraestrutura do banco de dados do projeto, utilizando Terraform.

---

### Função no Projeto

A principal responsabilidade deste repositório é provisionar um banco de dados PostgreSQL gerenciado (AWS RDS) de forma segura e isolada.

**Dependência Crítica:** Este projeto **depende** da infraestrutura de rede (VPC, sub-redes, etc.) criada pelo repositório `soat-challenge-infra-k8s`. Ele deve ser executado **após** a criação da VPC.

### Recursos Provisionados

* **AWS RDS:** Uma instância de banco de dados PostgreSQL gerenciada. A instância é configurada para não ser acessível publicamente (`publicly_accessible = false`).
* **DB Subnet Group:** Agrupa as sub-redes privadas da VPC onde o banco de dados será executado, garantindo alta disponibilidade.
* **Security Group:** Cria um Security Group (`soat-db-sg`) que permite tráfego de entrada na porta `5432` (PostgreSQL) **apenas** a partir do Security Group dos nós do EKS, garantindo comunicação segura e privada.

### Pré-requisitos

1.  **Conta AWS** e **Terraform** instalados.
2.  **Infraestrutura de Rede Existente:** A VPC (`soat-challenge-vpc`) e o Security Group do EKS (`soat-challenge-cluster-node`) devem ter sido criados previamente pelo projeto `infra-k8s`.
3.  **GitHub Secrets:**
    * `AWS_ACCESS_KEY_ID`
    * `AWS_SECRET_ACCESS_KEY`
    * `TF_VAR_db_password`: A senha a ser usada para o usuário master do banco de dados.

### Como Utilizar

O deploy é automatizado via GitHub Actions.

1.  **Alterações:** Faça as alterações de configuração do banco de dados (ex: tipo de instância) em uma branch e abra um Pull Request.
2.  **Merge:** Após o merge na `main`, o pipeline `deploy-database.yml` é acionado.
3.  **Deploy e Atualização do Segredo:** O workflow executa `terraform apply` e, em seguida, um passo crucial: ele extrai as saídas do Terraform (endpoint, porta, usuário, etc.) e constrói a `DATABASE_URL` completa. Por fim, ele atualiza o segredo `soat/db/database_url` no AWS Secrets Manager com essa nova URL. Isso garante que a aplicação Rails sempre tenha a string de conexão mais recente.
