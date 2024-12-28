# Estrutura do Projeto OpenShift com Terraform

## 1. Arquivos Raiz

### main.tf:
- Configura o provedor AWS e chama os módulos necessários para criar a infraestrutura do cluster OpenShift.
- Define módulos para VPC, EC2, grupos de segurança, armazenamento, monitoramento e IAM.

### variables.tf:
- Define as variáveis utilizadas em todo o projeto:
  - Variáveis básicas: região, tipo de instância, contagem de nós
  - Variáveis de rede: CIDR blocks, IDs de sub-rede
  - Variáveis de cluster: nome do cluster, ambiente, key pair, domain name
  - Variáveis de configuração: AMI, zona de disponibilidade

### outputs.tf:
- Define as saídas do Terraform:
  - IDs de VPC e subnets (públicas e privadas)
  - IPs dos nós de controle e de trabalho
  - Endpoint do cluster OpenShift
  - IDs dos grupos de segurança
  - URLs de acesso ao cluster

### tags.tf:
- Aplica tags padronizadas a todos os recursos
- Implementa tags específicas para gerenciamento de custos e identificação de recursos

## 2. Módulos

### modules/vpc/vpc.tf:
- Configura a VPC com suporte a DNS
- Implementa subnets públicas e privadas
- Configuração de alta disponibilidade com múltiplas AZs
- Inclui Internet Gateway e NAT Gateway

### modules/security_groups/security_groups.tf:
- Implementa grupos de segurança específicos para OpenShift:
  - Porta 6443 para API Server
  - Porta 22623 para Machine Config Server
  - Portas 80/443 para HTTP/HTTPS
  - Comunicação entre nós do cluster
- Regras de segurança baseadas em princípios de menor privilégio

### modules/ec2/ec2.tf:
- Configuração aprimorada das instâncias EC2:
  - Encryption dos volumes root
  - IAM instance profiles
  - User data para bootstrap
  - Key pairs para SSH
  - Tags específicas para OpenShift

### modules/storage/storage.tf:
- Implementa volumes EBS otimizados:
  - Usa volumes GP3 para melhor performance
  - Encryption por padrão
  - Tags para gerenciamento de custos
  - Integração com cluster OpenShift

### modules/monitoring/monitoring.tf:
- Implementação de monitoramento completo:
  - CloudWatch Logs
  - CloudWatch Metrics
  - AWS Config Rules
  - AWS CloudTrail

### modules/iam/iam.tf:
- Políticas IAM específicas para OpenShift:
  - Permissões para EC2
  - Acesso a Load Balancers
  - Integração com S3
  - Permissões Route53
  - Políticas de segurança granulares

## 3. Melhorias de Segurança

### Encryption e Segurança:
- KMS para encryption em repouso
- Security Groups com regras específicas
- Network ACLs para controle adicional
- IAM roles com menor privilégio

### Alta Disponibilidade:
- Distribuição de nós em múltiplas AZs
- Load balancers para control plane
- Auto scaling groups para workers

### Monitoramento e Backup:
- CloudWatch para logs e métricas
- Snapshots automáticos
- Políticas de backup
- Estratégia de DR

## 4. Próximos Passos

1. Implementar auto scaling para nós workers
2. Configurar backup automático
3. Implementar monitoramento avançado
4. Configurar DNS com Route53
5. Implementar políticas de compliance

## 5. Considerações de Manutenção

- Rotação regular de credenciais
- Atualizações de segurança
- Monitoramento de custos
- Backup e recuperação
- Documentação de procedimentos operacionais
