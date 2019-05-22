# docker-mariadb


Based on 

- DockerHub, [mariadb](https://hub.docker.com/_/mariadb) 
- GitHub, [mariadb](https://github.com/docker-library/mariadb)


## Config
support mariadb for `utf8mb4` encoding and Chinese Zone `Asia/Shanghai`.

If want to change the encoding, can change the cnf file in `conf` directory.


## Encoding 

The default encoding is `latin1`, and never change the encoding to `utf8` (not real utf8), but `utf8mb4` instead.


Also, can check the current encodings with SQL:

```
SHOW VARIABLES WHERE Variable_name LIKE 'character_set_%' OR Variable_name LIKE 'collation%';
```

After set, the results:

Variable_name	 | Value
------------- | -------------
`character_set_client` | utf8mb4
`character_set_connection` | utf8mb4
`character_set_database` | utf8mb4
`character_set_filesystem` | binary
`character_set_results` | utf8mb4
`character_set_server` | utf8mb4
`character_set_system` | utf8
`character_sets_dir` | /usr/share/mysql/charsets/
`collation_connection` | `utf8mb4_general_ci`
`collation_database` | `utf8mb4_unicode_ci`
`collation_server` | `utf8mb4_unicode_ci`



## Usage


```
docker run --name my-mariadb -e MYSQL_ROOT_PASSWORD=my-secret -d kemixkoo/mariadb
```


### Custom DB Data

```
docker run --name my-mariadb \
    -v /my/data/path:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=my-secret \
    -d kemixkoo/mariadb
```

### Custom DB and User

```
docker run --name my-mariadb \
    -v /my/data/path:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=my-secret \
    -e MYSQL_DATABASE=sample \
    -e MYSQL_USER=my-user \
    -e MYSQL_PASSWORD=my-password \
    -d kemixkoo/mariadb
```


### Docker-compose
```
version: '3.1'

services:

  mariadb:
    image: kemixkoo/mariadb
    restart: always
    environment:
      MYSQL_DATABASE: example
      MYSQL_ROOT_PASSWORD: password
      MYSQL_USER: user
      MYSQL_PASSWORD: password
    volumes:
      - ~/mariadb:/var/lib/mysql

  adminer:
    image: adminer
    restart: always
    ports:
      - 18080:8080
```

The DB data directory is in `~/mariadb` for volume.

Then, can access the adminer: http://localhost:18080

## Building

```
docker build -t kemixkoo/mariadb .
```


## Addition

### Use Official Image

Use the official MariaDB with adminer in docker-compose way:

```
version: '3.1'

services:

  mariadb:
    image: mariadb
    restart: always
    environment:
      MYSQL_DATABASE: example
      MYSQL_ROOT_PASSWORD: password
      MYSQL_USER: user
      MYSQL_PASSWORD: password
    volumes:
      - ~/mariadb:/var/lib/mysql
      - ./conf:/etc/mysql/conf.d

  adminer:
    image: adminer
    restart: always
    ports:
      - 17070:8080
```

If want to support the `utf8mb4` encoding, can add `./conf` for volume.

Then, can access http://localhost:17070

