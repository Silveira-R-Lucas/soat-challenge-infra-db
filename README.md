# SOAT - Infraestrutura de Base de Dados (infra-db) - Fase 04
Este repositório é dedicado exclusivamente ao provisionamento e gestão da infraestrutura de persistência de dados poliglota do projeto utilizando Terraform. Na Fase 4, a infraestrutura foi expandida para suportar as necessidades específicas de cada microsserviço (Relacional, NoSQL e Cache).

## 🚀 Evoluções da Fase 04
Persistência Poliglota: Provisionamento de três motores de base de dados distintos:

PostgreSQL (AWS RDS): Para o serviço de pedidos, garantindo integridade ACID.

Redis (AWS ElastiCache): Para gestão de estado em tempo real no serviço de cozinha.

MongoDB (AWS DocumentDB): Para o serviço de pagamentos, oferecendo esquemas flexíveis.

Construção Automática de URLs: O pipeline agora gera e injeta URLs de conexão completas diretamente no AWS Secrets Manager, facilitando o consumo pelas aplicações.

Qualidade e Segurança: Integração com SonarCloud e Checkov para garantir que a infraestrutura de dados siga as melhores práticas de segurança.

## 🏗️ Recursos Provisionados
AWS RDS (PostgreSQL): Instância gerida e configurada como não acessível publicamente para maior segurança.

AWS ElastiCache (Redis): Cluster de nó único para processamento de filas e cache de alta performance.

AWS DocumentDB (MongoDB): Cluster NoSQL compatível com MongoDB para armazenamento de transações de pagamento.

Grupos de Segurança (Security Groups): Configuração de regras de entrada que permitem conexões apenas a partir dos nós do cluster EKS nas portas correspondentes (5432, 6379, 27017).

## 🛡️ Qualidade e CI/CD
O pipeline de CI/CD no GitHub Actions automatiza o ciclo de vida dos dados:

Checkov Scan: Validação de segurança para evitar exposições de portas ou falta de encriptação em repouso.

SonarCloud Scan: Análise estática do código Terraform para garantir manutenibilidade.

Terraform Test: Execução de testes automatizados (db_logic.tftest.hcl) para validar se os bancos são criados como privados e com os motores correctos.

## ⚙️ Gestão de Segredos (AWS Secrets Manager)
Após o sucesso do apply, o pipeline atualiza automaticamente os seguintes segredos no Secrets Manager:

soat/db/database_url: URL de conexão PostgreSQL.

soat/db/redis_url: URL de conexão Redis.

soat/db/mongodb_url: URL de conexão MongoDB.

## 📋 Pré-requisitos e Dependências
Dependência Crítica: Este projeto depende da infraestrutura de rede (VPC e sub-redes) e do Security Group dos nós criado pelo repositório soat-challenge-infra-k8s.

GitHub Secrets Necessários:

AWS_ACCESS_KEY_ID / AWS_SECRET_ACCESS_KEY

TF_VAR_db_password: Senha master do RDS.

TF_VAR_MONGO_USERNAME / TF_VAR_MONGO_PASSWORD: Credenciais do DocumentDB.

SONAR_TOKEN: Para integração com SonarCloud.

## 🛠️ Como Utilizar
Garanta que o repositório infra-k8s já foi aplicado com sucesso.

Abra um Pull Request para a branch main para visualizar o terraform plan.

Após o merge, o pipeline executará o terraform apply e atualizará as strings de conexão no Secrets Manager.

Os microsserviços consumirão essas URLs automaticamente no próximo deploy ou reinício.
