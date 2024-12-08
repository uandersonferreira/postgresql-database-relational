# **Backup e Restauração no PostgreSQL**

## **Introdução**

Backup no PostgreSQL é essencial para evitar perda de dados em caso de falhas, erros ou desastres. Existem dois tipos de backup:

- **Backup lógico**: Cópia da estrutura e/ou dados do banco.
- **Backup físico**: Cópia dos arquivos do sistema de dados.

Utilizaremos o **pg_dump** e o **pg_dumpall** para realizar backups lógicos.

## **Ferramentas para Backup**

### **pg_dump**

- Faz backup de um banco de dados específico.
- Sintaxe básica:

  ```bash
  pg_dump [opções_de_conexão] [opções] [nome_banco]
  ```

- Principais opções:
  - `-U` (username): Especifica o usuário de conexão.
  - `-h` (host): Especifica o endereço do servidor.
  - `-p` (port): Porta do servidor PostgreSQL.
  - `-d` (dbname): Nome do banco de dados a ser copiado.
  - `-F` (format): Define o formato de saída (ex: `tar`, `plain`, `custom`).
  - `-f` (file): Define o nome do arquivo de saída.
  - `-a`: Faz backup apenas dos dados.
  - `-s`: Faz backup apenas do esquema (estrutura).

### **pg_dumpall**

- Faz backup de todos os bancos de dados do cluster PostgreSQL.
- Sintaxe básica:

  ```bash
  pg_dumpall [opções_de_conexão]
  ```

- Principais opções:
  - `-g`: Faz backup apenas de objetos globais (ex: roles, tablespaces).
  - `-r`: Faz backup apenas de roles.
  - `-c`: Adiciona comandos para limpar (drop) objetos antes de recriá-los.
  - `-s`: Faz backup apenas do esquema, sem dados.

---

## **Passo a Passo: Backup com `pg_dump`**

### **1. Fazer Backup de um Banco de Dados Específico**

```bash
pg_dump -U postgres -d nome_do_banco -F tar -f /caminho/para/backup/nome_do_banco.tar
```

- **Explicação**:
  - `-U postgres`: Usuário que se conecta ao PostgreSQL.
  - `-d nome_do_banco`: Banco de dados a ser copiado.
  - `-F tar`: Arquivo de backup no formato tar.
  - `-f /caminho/para/backup/nome_do_banco.tar`: Caminho e nome do arquivo de backup.

### **2. Fazer Backup de Todos os Bancos de Dados com `pg_dumpall`**

```bash
pg_dumpall -U postgres > /caminho/para/backup/all_databases.sql
```

- **Explicação**:
  - Cria um backup de todos os bancos de dados em um arquivo SQL único.

### **3. Automatizar Backup (Script Bash para Linux/macOS)**

```bash
#!/bin/bash

# Definir variáveis de conexão
PGUSER=seu_usuario
PGDATABASE=seu_banco
BACKUP_DIR=/caminho/para/backup

# Gerar data e hora
datestamp=$(date +'%Y-%m-%d')
timestamp=$(date +'%H%M')

# Executar pg_dump para criar o backup
pg_dump -U "$PGUSER" -d "$PGDATABASE" > "$BACKUP_DIR/$PGDATABASE"_"$datestamp"_"$timestamp".sql
```

- **Passos**:
  1. Salve o script como `backup.sh`.
  2. Execute no terminal:
  
  ```bash
  chmod +x backup.sh
  ./backup.sh
  ```

### **4. Automatizar Backup no Windows (Script .bat)**

```batch
@echo off
set PGUSER=seu_usuario
set PGDATABASE=seu_banco
set BACKUP_DIR=C:\caminho\para\backup

for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set "datestamp=%%c-%%a-%%b")
for /f "tokens=1-2 delims=: " %%a in ('time /t') do (set "timestamp=%%a%%b")

pg_dump -U %PGUSER% -d %PGDATABASE% -f "%BACKUP_DIR%\%PGDATABASE%_%datestamp%_%timestamp%.sql"
```

- **Passos**:
  1. Salve como `backup.bat`.
  2. Execute clicando duas vezes no arquivo.

---

## **Restauração de Backup**

### **1. Restauração de Backup de um Único Banco**

```bash
psql -U postgres -d nome_do_banco -f /caminho/para/backup/nome_do_banco.sql
```

- **Explicação**:
  - `-U postgres`: Usuário que se conecta ao PostgreSQL.
  - `-d nome_do_banco`: Banco de dados a ser restaurado.
  - `-f nome_do_banco.sql`: Caminho para o arquivo de backup.

### **2. Restauração de Todos os Bancos**

```bash
psql -U postgres -f /caminho/para/backup/all_databases.sql
```

---

## **Resumo**

1. **Backup de um banco**: Use `pg_dump`.
2. **Backup de todos os bancos**: Use `pg_dumpall`.
3. **Automatize com scripts** para executar backups periodicamente.
4. **Restaure backups** com o comando `psql`.

## Comandos usados na aula
>
> <https://www.youtube.com/watch?v=ZBWx-CA0jdk&list=PLucm8g_ezqNoAkYKXN_zWupyH6hQCAwxY&index=31>

```sql

-- Gerar o backup pelo terminal do linux 

sudo -u user_database pg_dump nome_database >  /caminho/nome_backup.extensão
-- informar a senha do user_database


-- Passos para deletar um banco com conexões ativas

-- 1. Tirar a permissão de se conectar ao banco
REVOKE CONNECT on DATABASE name_database from PUBLIC;

-- 2. Terminar as conexões do banco de dados ativas
SELECT pg_terminate_backend(pg_stat_activity.pid)
from pg_stat_activity
where pg_stat_activity.datname = 'name_database';

-- 3. Deletar de fato o banco de dados
DROP DATABASE name_database;


-- 4. ===== RESTAURAÇÃO DO BACKUP =====
CREATE DATABASE name_database TEMPLATE template0; -- cria um banco vazio

-- 5. Restaurar com o pg_dump
sudo -u postgres psql name_database < /caminho/nome_backup.extensão
-- informe a senha do user_database

```
