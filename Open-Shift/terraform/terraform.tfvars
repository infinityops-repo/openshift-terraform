ami                 = "ami-0583d8c7a9c35822c"  # Substitua pelo ID da AMI desejada
availability_zone   = "us-east-1a"             # Substitua pela zona de disponibilidade desejada
control_plane_count = 3                          # Número de instâncias para o nó de controle
worker_node_count   = 3                          # Número de instâncias para os nós de trabalho
ebs_volume_size     = 100                        # Tamanho dos volumes EBS em GB
vpc_cidr            = "10.0.0.0/16"              # CIDR block para a VPC
public_subnet_cidr  = "10.0.1.0/24"              # CIDR block para a sub-rede pública
private_subnet_cidr = "10.0.2.0/24"              # CIDR block para a sub-rede privada
instance_type       = "m5.large"  # ou "m5.xlarge" dependendo das suas necessidades
security_group_id   = "sg-0123456789abcdef0"  # Substitua pelo ID do seu grupo de segurança
subnet_id           = "subnet-0123456789abcdef0"  # Substitua pelo ID da sua sub-rede
vpc_id              = "vpc-0123456789abcdef0"  # Substitua pelo ID da sua VPC