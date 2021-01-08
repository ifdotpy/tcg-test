# Установка по тестовому заданию

## Базовый софт
### Terraform
-  Устанавливаем согласно вашей ОС https://www.terraform.io/downloads.html
### Ansible
- Устанавливаем согласно вашей ОС https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html

## Конфигурации
- В папке infra создайте файл `secret.tfvars` со следующим содержанием:
```
do_token="<ваш API токен к Digitalocean>"
allow_ssh_ips = ["<IP-адрес устройства, с которого будет осуществлятся доступ к ssh >"] 
# При надобности, в список можно добалять любое количество IP
```

## Установка
- Поднимаем инфрастуктуру на DO:
```bash
    cd infra
    terraform apply -var-file=secret.tfvars -auto-approve 
```
- Настраиваем приложение:
```bash
    cd ../tcg-systemd
    ansible-playbook deploy.yml
```
- В файле `infra/inventory` можно увидеть IP адреса серверов, которые были подняты.

- По окончанию проверки, освободить все занятые сервера можно так:
```bash
    cd ../infra
    terraform destroy -var-file=secret.tfvars -auto-approve
```

# BONUS: Установка с помощью Docker

## Базовый софт
### Terraform
-  Устанавливаем согласно вашей ОС https://www.terraform.io/downloads.html
### Ansible
- Устанавливаем согласно вашей ОС https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html

## Конфигурации
- В папке infra создайте файл `secret.tfvars` со следующим содержанием:
```
do_token="<ваш API токен к Digitalocean>"
allow_ssh_ips = ["<IP-адрес устройства, с которого будет осуществлятся доступ к ssh >"] 
# При надобности, в список можно добалять любое количество IP
```

## Установка
- Поднимаем инфрастуктуру на DO:
```bash
    cd infra
    terraform apply -var-file=secret.tfvars -auto-approve 
```
- Настраиваем приложение:
```bash
    cd ..
    ansible-playbook deploy.yml
```
- В файле `infra/inventory` можно увидеть IP адреса серверов, которые были подняты.

- По окончанию проверки, освободить все занятые сервера можно так:
```bash
    cd infra
    terraform destroy -var-file=secret.tfvars -auto-approve
```