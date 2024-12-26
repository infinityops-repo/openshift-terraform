# Estrutura do Projeto OpenShift com Terraform

## 1. Arquivos Raiz

### main.tf:
- Configura o provedor AWS e chama os módulos necessários para criar a infraestrutura do cluster OpenShift.
- Define módulos para VPC, EC2, grupos de segurança, armazenamento, monitoramento e IAM.

### variables.tf:
- Define as variáveis utilizadas em todo o projeto, como tipo de instância, contagem de nós, AMI, IDs de sub-rede e grupo de segurança, CIDR da VPC e zona de disponibilidade.

### outputs.tf:
- Define as saídas do Terraform, como o ID da VPC, IPs dos nós de controle e de trabalho, e ID do grupo de segurança.

### tags.tf:
- Aplica tags a todos os recursos criados para facilitar a organização e o gerenciamento.

## 2. Módulos

### modules/vpc/vpc.tf:
- Configura a VPC e as sub-redes.
- Cria a VPC com suporte a DNS e define sub-redes públicas e privadas.

### modules/security_groups/security_groups.tf:
- Configura os grupos de segurança para controlar o tráfego de entrada e saída.
- Permite tráfego HTTP, HTTPS e outras portas necessárias para o OpenShift.

### modules/ec2/ec2.tf:
- Configura as instâncias EC2 para o cluster OpenShift.
- Cria instâncias para o nó de controle e nós de trabalho, aplicando tags e configurando segurança.

### modules/storage/storage.tf:
- Configura o armazenamento persistente para os nós de trabalho.
- Cria volumes EBS e os anexa às instâncias dos nós de trabalho.

### modules/monitoring/variables.tf:
- Define variáveis específicas para o módulo de monitoramento (placeholder para futuras configurações).

## 3. Arquivos de Configuração

### terraform/.terraform/modules/modules.json:
- Arquivo gerado automaticamente pelo Terraform que contém informações sobre os módulos utilizados no projeto.

## Resumo dos Componentes

### Arquivos Raiz:
- main.tf
- variables.tf
- outputs.tf
- tags.tf

### Módulos:
- modules/vpc/vpc.tf
- modules/security_groups/security_groups.tf
- modules/ec2/ec2.tf
- modules/storage/storage.tf
- modules/monitoring/variables.tf

### Arquivos de Configuração:
- terraform/.terraform/modules/modules.json
