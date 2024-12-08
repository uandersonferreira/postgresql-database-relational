
1. pqsl

psql: FATAL: role "user_name" does not exist

- Isso ocorre porque o usuário do sistema não existe no banco de dados. Portanto temos que acessar com o postgres (user default do gerenciamento dos bancos e do Linux) é criar esse novo usuário no banco.

1. sudo -i -u postgres
2. psql

- \conninfo (para saber o tipo de autenticação feita ao banco)
- via soquete - autenticação feita com um user do Linux.
- \password (dentro do psql para definir uma senha para o user)
- \q (para sair)

1. psql

- vai entrar direto no banco de dados mesmo tendo definido a senha para o user. Comportamento padrão do postgresql.

- show hba_file; (dentro do psql executar para localizar o arquivo de configuração de autenticação dos clients do  postgresql "pg_hba.conf" que permite mudar esse comportamento de autenticação)
(PostgreSQL Client Authentication Configuration File)

- No terminal normal do sistema abrir o arquivo e editar
  - sudo nano /caminho_do_file

# Database administrative login by Unix domain socket (Para definir o method de autentication)

|# TYPE     | DATABASE       | USER        |  ADDRESS      | METHOD      |
|:---------:|:--------------:|:-----------:|:-------------:|:-----------:|
| local     |     all        |  postgres   |               |   md5       |

- ctrl + O  e Enter (para salvar)
- ctrl + X (para sair do nano)

- sudo systemctl restart postgresql (reinicia o serviço para aplicar as mudanças)

- psql -U postgres (basicamente estamos dizendo psql abra com o user postgres)

### PostgreSQL - Como criar e excluir usuários com createuser e dropuser

- Wrappers: comando que simplifica outro comando

- No terminal do useer do linux: sudo -i -u postgres (logar com um superuser que existe no banco de dados)

- No terminal do postgres: man createuser (apresenta um manual completo com as informações sobre o comando)

```bash
  createuser -dPs  name_user
```

- Defina a senha do novo user
- Confirme com a senha do superuser postgres definida no banco

```bash
  createuser --interactive  name_user
```

- Dessa forma, irá perguntar os itens que queremos configurar para o novo user

- Devemos configurar a autenticação para esse novo user

# Database administrative login by Unix domain socket (Para definir o method de autentication)

|# TYPE     | DATABASE       | USER        |  ADDRESS      | METHOD      |
|:---------:|:--------------:|:-----------:|:-------------:|:-----------:|
| local     |     all        |  postgres   |               |   md5       |
| local     |     all        |  name_user  |               |   md5       |

```bash
    psql -U name_user name_database_exit 
```

> Se tentar logar com  psql -U name_user (provavelmente vai dar erro, pois não existe um banco de dados com o nome do user criado), pois
> comando irá tentar logar fazendo a associação do nome do user com um banco de mesmo nome.
> Quando usamos com o postgres funciona porque é criado um banco default com o mesmo nome do user default.

### Comando `createuser`

> Documentation official: <https://www.postgresql.org/docs/7.3/app-createuser.html>
> Documentation: <https://linux.die.net/man/1/createuser>

O comando `createuser` é utilizado para criar uma nova conta de usuário no PostgreSQL. Somente superusuários (aqueles que possuem o atributo `usesuper` na tabela `pg_shadow`) têm permissão para criar novos usuários, portanto, o `createuser` deve ser executado por alguém com privilégios de superusuário.

#### Sintaxe

```bash
createuser [opções...] [nome_do_usuário]
```

### Comando dropuser

- Logar com um user que têm permissões de superuser (como o postgres default)
  - `sudo -i -u postgres`
    - `dropuser name_user`
    - Confirme com a senha do superuser
    - para verificar se removeu corretamente acesse o `psql`
    - E execute o comando `\du`

> Documentantion: <https://www.postgresql.org/docs/current/app-dropuser.html>

#### Descrição

O `createuser` é um script que envolve o comando SQL `CREATE USER` dentro do terminal interativo `psql` do PostgreSQL. Ele não é diferente de criar usuários usando outras formas. Para funcionar, o script precisa encontrar o aplicativo `psql` e garantir que um servidor de banco de dados esteja em execução no host alvo. As configurações padrão e variáveis de ambiente usadas pelo `psql` e pela biblioteca front-end `libpq` também serão aplicadas.

#### Opções

- **username**: Define o nome do usuário PostgreSQL a ser criado. Esse nome deve ser único entre todos os usuários do PostgreSQL.
  
- **-a, --adduser**: Permite que o novo usuário crie outros usuários (ou seja, torna o usuário um superusuário).

- **-A, --no-adduser**: Impede que o novo usuário crie outros usuários (ou seja, o usuário será um usuário regular, não um superusuário).

- **-d, --createdb**: Permite que o novo usuário crie bancos de dados.

- **-D, --no-createdb**: Impede que o novo usuário crie bancos de dados.

- **-e, --echo**: Exibe as consultas SQL geradas e enviadas ao servidor.

- **-E, --encrypted**: Criptografa a senha do usuário armazenada no banco de dados.

- **-i uid, --sysid uid**: Permite escolher um ID de usuário não padrão para o novo usuário.

- **-N, --unencrypted**: Não criptografa a senha do usuário armazenada no banco de dados.

- **-P, --pwprompt**: Solicita uma senha para o novo usuário.

- **-q, --quiet**: Não exibe uma resposta ao criar o usuário.

#### Parâmetros de Conexão

- **-h host, --host host**: Especifica o nome do host onde o servidor está sendo executado.

- **-p port, --port port**: Define a porta TCP/IP ou o arquivo de socket Unix local onde o servidor está ouvindo conexões.

- **-U username, --username username**: Nome do usuário a ser utilizado para conectar (não é o nome do usuário a ser criado).

- **-W, --password**: Força a solicitação de senha para conectar ao servidor.

#### Exemplo de Uso

Criação de um usuário chamado `novo_usuario`, que pode criar bancos de dados, mas não pode criar outros usuários:

```bash
createuser --createdb --no-adduser novo_usuario
```

Os principais métodos de autenticação e suas configurações:

> Documentation: <https://www.postgresql.org/docs/9.1/auth-methods.html>

### 1. **Trust Authentication**

- **Descrição**: Permite a conexão sem autenticação (sem senha), ideal para ambientes de desenvolvimento ou locais seguros.
  - **Configuração**:

     ```conf
     host    all    all    192.168.1.0/24    trust
     ```

  - **Diferença**: Não há necessidade de senha. Muito inseguro para ambientes de produção.

### 2. **Password Authentication**

- **Descrição**: Exige que o cliente forneça uma senha, mas a senha é transmitida sem criptografia.
- **Configuração**:

     ```conf
     host    all    all    192.168.1.0/24    password
     ```

- **Diferença**: Simples, mas a senha pode ser interceptada em conexões inseguras (sem SSL).

### 3. **MD5 Authentication**

- **Descrição**: Uma variante de autenticação por senha, que envia uma senha criptografada usando MD5.
- **Configuração**:

     ```conf
     host    all    all    192.168.1.0/24    md5
     ```

- **Diferença**: Mais seguro que `password`, já que a senha não é transmitida em texto puro.

### 4. **SCRAM-SHA-256 Authentication**

- **Descrição**: Autenticação segura usando o algoritmo SCRAM-SHA-256.
- **Configuração**:

     ```conf
     host    all    all    192.168.1.0/24    scram-sha-256
     ```

- **Diferença**: Substitui MD5 como padrão mais seguro, recomendado para novos sistemas.

### 5. **GSSAPI Authentication**

- **Descrição**: Usado para autenticação baseada em tickets Kerberos. Requer que o servidor e o cliente estejam configurados com Kerberos.
- **Configuração**:

     ```conf
     host    all    all    192.168.1.0/24    gss
     ```

- **Diferença**: Para ambientes corporativos que usam Kerberos. Mais complexo de configurar.

### 6. **SSPI Authentication**

- **Descrição**: Similar ao GSSAPI, mas específico para ambientes Windows, usando o protocolo de autenticação do Windows.
- **Configuração**:

     ```conf
     host    all    all    192.168.1.0/24    sspi
     ```

- **Diferença**: Usado apenas em Windows, integrado com o Active Directory.

### 7. **Kerberos Authentication**

- **Descrição**: Usa o protocolo Kerberos diretamente para autenticar, exigindo um KDC (Key Distribution Center).
- **Configuração**:

     ```conf
     host    all    all    192.168.1.0/24    kerberos
     ```

- **Diferença**: Similar ao GSSAPI, porém mais direto.

### 8. **Ident Authentication**

- **Descrição**: Verifica a identidade do usuário do sistema local usando o serviço Ident.
- **Configuração**:

     ```conf
     host    all    all    192.168.1.0/24    ident
     ```

- **Diferença**: Autentica com base no sistema operacional, mas depende de servidores Ident.

### 9. **Peer Authentication**

- **Descrição**: Autentica usuários locais verificando se o nome de usuário do SO corresponde ao nome do banco de dados.
- **Configuração**:

     ```conf
     local    all    all    peer
     ```

- **Diferença**: Usado para conexões locais, sem necessidade de senha.

### 10. **LDAP Authentication**

- **Descrição**: Integra com servidores LDAP (como Active Directory) para autenticação.
- **Configuração**:

     ```conf
     host    all    all    192.168.1.0/24    ldap ldapserver=ldap.example.com ldapprefix="uid=" ldapsuffix=",ou=users,dc=example,dc=com"
     ```

- **Diferença**: Ideal para ambientes que já usam LDAP para autenticação centralizada.

### Diferenças Resumidas

- **Trust**: Sem autenticação, sem senha.
- **Password/MD5/SCRAM-SHA-256**: Baseado em senha, variando o nível de criptografia.
- **GSSAPI/SSPI/Kerberos**: Integração com autenticação Kerberos (ou Windows).
- **Ident/Peer**: Verificam o usuário do SO.
- **LDAP**: Autenticação via servidor LDAP externo.
