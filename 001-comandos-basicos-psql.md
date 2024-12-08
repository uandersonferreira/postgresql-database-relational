# Curso de PostgreSQL

---

### **Comandos Básicos do Utilitário `psql` no PostgreSQL**

## **Verificação de Versão e Ajuda**
- **Verificar a versão do `psql`:**
  ```bash
  psql --version
  ```
  Use este comando para verificar qual versão do PostgreSQL está instalada.

- **Obter ajuda geral:**
  ```bash
  psql --help
  ```
  Este comando exibe uma lista de opções e flags disponíveis para o `psql`.

## **Acesso ao Superusuário `postgres`**
- **Logar como superusuário `postgres`:**
  ```bash
  sudo -i -u postgres
  ```
  `postgres` é o superusuário padrão criado durante a instalação do PostgreSQL.

- **Entrar no `psql`:**
  ```bash
  psql
  ```
  Após logar como `postgres`, este comando abre o terminal do `psql`, indicado pelo prompt `postgres=#`.

- **Definir senha para o usuário `postgres`:**
  ```bash
  \password
  ```
  Este comando permite definir ou alterar a senha do usuário `postgres`.

## **Comandos Internos do `psql`**
- **Listar comandos SQL disponíveis:**
  ```bash
  \h
  ```
  Use este comando para ver uma lista de todos os comandos SQL suportados.

- **Obter ajuda sobre um comando SQL específico:**
  ```bash
  \h comando_sql
  ```
  Substitua `comando_sql` pelo nome do comando desejado (ex: `SELECT`) para ver detalhes sobre seu uso.

- **Listar comandos internos do `psql`:**
  ```bash
  \?
  ```
  Este comando exibe uma lista dos comandos internos do `psql` que são utilizados para interagir com o banco.

## **Gerenciamento de Bancos e Usuários**
- **Listar todos os bancos de dados:**
  ```bash
  \l
  ```
  Exibe uma lista de todos os bancos de dados disponíveis.

- **Listar todos os usuários:**
  ```bash
  \du
  ```
  Mostra uma lista de todos os usuários e seus respectivos papéis no banco de dados.

- **Conectar a um banco de dados específico:**
  ```bash
  \c nome_do_banco
  ```
  Use este comando para mudar para um banco de dados específico, substituindo `nome_do_banco` pelo nome desejado.

## **Gerenciamento de Tabelas**
- **Listar tabelas do banco de dados atual:**
  ```bash
  \d
  ```
  Este comando mostra todas as tabelas disponíveis no banco de dados atual.

- **Listar tabelas do sistema:**
  ```bash
  \dS
  ```
  Exibe tabelas e esquemas do sistema do banco de dados.

## **Executar Comandos do Sistema**
- **Sair temporariamente do `psql` para o terminal do sistema:**
  ```bash
  \!
  ```
  Use este comando para acessar o terminal do sistema sem sair do `psql`. Para retornar ao `psql`, digite `exit`.

- **Executar um comando do sistema diretamente:**
  ```bash
  \! comando_do_sistema
  ```
  Substitua `comando_do_sistema` pelo comando que deseja executar no terminal do sistema.

## **Saída do `psql`**
- **Sair do `psql`:**
  ```bash
  \q
  ```
  Este comando fecha o terminal do `psql` e retorna ao terminal do sistema.

## **Localização do Utilitário `psql`**
- **Verificar o caminho de instalação do `psql`:**
  ```bash
  which psql
  ```
  Mostra o caminho completo onde o `psql` está instalado no sistema.