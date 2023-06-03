Docker Compose test all images
==============================

This is a docker-compose version of the Lando example tests:

Start up tests
--------------

Run the following commands to get up and running with this example.

```bash
# should remove any previous runs and poweroff
sed -i -e "/###/d" docker-compose.yml
docker network inspect amazeeio-network >/dev/null || docker network create amazeeio-network
docker-compose down

# should start up our services successfully
docker-compose build && docker-compose up -d

# Ensure database pods are ready to connect
docker run --rm --net all-images_default jwilder/dockerize dockerize -wait tcp://mariadb-10-4:3306 -timeout 1m
docker run --rm --net all-images_default jwilder/dockerize dockerize -wait tcp://mariadb-10-5:3306 -timeout 1m
docker run --rm --net all-images_default jwilder/dockerize dockerize -wait tcp://mariadb-10-6:3306 -timeout 1m
docker run --rm --net all-images_default jwilder/dockerize dockerize -wait tcp://mariadb-10-11:3306 -timeout 1m
docker run --rm --net all-images_default jwilder/dockerize dockerize -wait tcp://postgres-11:5432 -timeout 1m
docker run --rm --net all-images_default jwilder/dockerize dockerize -wait tcp://postgres-12:5432 -timeout 1m
docker run --rm --net all-images_default jwilder/dockerize dockerize -wait tcp://postgres-13:5432 -timeout 1m
docker run --rm --net all-images_default jwilder/dockerize dockerize -wait tcp://postgres-14:5432 -timeout 1m
docker run --rm --net all-images_default jwilder/dockerize dockerize -wait tcp://postgres-15:5432 -timeout 1m
docker run --rm --net all-images_default jwilder/dockerize dockerize -wait tcp://mongo-4:27017 -timeout 1m
docker run --rm --net all-images_default jwilder/dockerize dockerize -wait tcp://rabbitmq:15672 -timeout 1m
docker run --rm --net all-images_default jwilder/dockerize dockerize -wait tcp://opensearch-2:9200 -timeout 1m
```

Verification commands
---------------------

Run the following commands to validate things are rolling as they should.

```bash
# should have all the services we expect
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_commons_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_mariadb-10-4_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_mariadb-10-5_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_mariadb-10-6_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_mariadb-10-11_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_mongo-4_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_node-16_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_node-18_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_node-20_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_postgres-11_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_postgres-12_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_postgres-13_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_postgres-14_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_postgres-15_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_php-8-0-dev_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_php-8-0-prod_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_php-8-1-dev_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_php-8-1-prod_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_php-8-2-dev_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_php-8-2-prod_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_python-3-7_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_python-3-8_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_python-3-9_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_python-3-10_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_python-3-11_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_rabbitmq_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_redis-5_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_redis-6_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_redis-7_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_ruby-3-0_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_ruby-3-1_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_ruby-3-2_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_solr-7_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_solr-8_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_varnish-6_1
docker ps --filter label=com.docker.compose.project=all-images | grep Up | grep all-images_varnish-7_1

# commons should be running Alpine Linux
docker-compose exec -T commons sh -c "cat /etc/os-release" | grep "Alpine Linux"

# rabbitmq should have RabbitMQ running 3.10
docker-compose exec -T rabbitmq sh -c "rabbitmqctl version" | grep 3.10

# rabbitmq should have delayed_message_exchange plugin enabled
docker-compose exec -T rabbitmq sh -c "rabbitmq-plugins list" | grep "E" | grep "delayed_message_exchange"

# rabbitmq should have a running RabbitMQ management page running on 15672
docker-compose exec -T commons sh -c "curl -kL http://rabbitmq:15672" | grep "RabbitMQ Management"

# redis-5 should be running Redis v5.0
docker-compose exec -T redis-5 sh -c "redis-server --version" | grep v=5.

# redis-5 should be able to see databases
docker-compose exec -T redis-5 sh -c "redis-cli CONFIG GET databases"

# redis-5 should have initialized database
docker-compose exec -T redis-5 sh -c "redis-cli dbsize"

# redis-5 should be able to read/write data
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/redis-5" | grep "SERVICE_HOST=redis-5"
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/redis-5" | grep "LAGOON_TEST_VAR=all-images"

# redis-6 should be running Redis v6.0
docker-compose exec -T redis-6 sh -c "redis-server --version" | grep v=6.

# redis-6 should be able to see Redis databases
docker-compose exec -T redis-6 sh -c "redis-cli CONFIG GET databases"

# redis-6 should have initialized database
docker-compose exec -T redis-6 sh -c "redis-cli dbsize"

# redis-6 should be able to read/write data
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/redis-6" | grep "SERVICE_HOST=redis-6"
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/redis-6" | grep "LAGOON_TEST_VAR=all-images"

# redis-7 should be running Redis v7.0
docker-compose exec -T redis-7 sh -c "redis-server --version" | grep v=7.

# redis-7 should be able to see Redis databases
docker-compose exec -T redis-7 sh -c "redis-cli CONFIG GET databases"

# redis-7 should have initialized database
docker-compose exec -T redis-7 sh -c "redis-cli dbsize"

# redis-7 should be able to read/write data
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/redis-7" | grep "SERVICE_HOST=redis-7"
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/redis-7" | grep "LAGOON_TEST_VAR=all-images"

# solr-7 should have a "mycore" Solr core
docker-compose exec -T commons sh -c "curl solr-7:8983/solr/admin/cores?action=STATUS\&core=mycore"

# solr-7 should be able to reload "mycore" Solr core
docker-compose exec -T commons sh -c "curl solr-7:8983/solr/admin/cores?action=RELOAD\&core=mycore"

# solr-7 should have solr 7.7 solrconfig in "mycore" core
docker-compose exec -T solr-7 sh -c "cat /opt/solr/server/solr/mycores/mycore/conf/solrconfig.xml" | grep luceneMatchVersion | grep 7.7

# solr-7 should be able to read/write data
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/solr-7" | grep "SERVICE_HOST=solr-7"
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/solr-7" | grep "LAGOON_TEST_VAR=all-images"

# solr-8 should have a "mycore" Solr core
docker-compose exec -T commons sh -c "curl solr-8:8983/solr/admin/cores?action=STATUS\&core=mycore"

# solr-8 should be able to reload "mycore" Solr core
docker-compose exec -T commons sh -c "curl solr-8:8983/solr/admin/cores?action=RELOAD\&core=mycore"

# solr-8 should have solr 8 solrconfig in "mycore" core
docker-compose exec -T solr-8 sh -c "cat /var/solr/data/mycore/conf/solrconfig.xml" | grep luceneMatchVersion | grep 8.

# solr-8 should be able to read/write data
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/solr-8" | grep "SERVICE_HOST=solr-8"
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/solr-8" | grep "LAGOON_TEST_VAR=all-images"

# mariadb-10-4 should be version 10.4 client
docker-compose exec -T mariadb-10-4 sh -c "mysql -V" | grep "10.4"

# mariadb-10-4 should be version 10.4 server
docker-compose exec -T mariadb-10-4 sh -c "mysql -e \'SHOW variables;\'" | grep "version" | grep "10.4"

# mariadb-10-4 should use default credentials
docker-compose exec -T mariadb-10-4 sh -c "mysql -D lagoon -u lagoon --password=lagoon -e \'SHOW databases;\'" | grep lagoon

# mariadb-10-4 should be able to read/write data
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/mariadb-10-4" | grep "SERVICE_HOST=10.4"
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/mariadb-10-4" | grep "LAGOON_TEST_VAR=all-images"

# mariadb-10-5 should be version 10.5 client
docker-compose exec -T mariadb-10-5 sh -c "mysql -V" | grep "10.5"

# mariadb-10-5 should be version 10.5 server
docker-compose exec -T mariadb-10-5 sh -c "mysql -e \'SHOW variables;\'" | grep "version" | grep "10.5"

# mariadb-10-5 should use default credentials
docker-compose exec -T mariadb-10-5 sh -c "mysql -D lagoon -u lagoon --password=lagoon -e \'SHOW databases;\'" | grep lagoon

# mariadb-10-5 should be able to read/write data
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/mariadb-10-5" | grep "SERVICE_HOST=10.5"
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/mariadb-10-5" | grep "LAGOON_TEST_VAR=all-images"

# mariadb-10-6 should be version 10.6 client
docker-compose exec -T mariadb-10-6 sh -c "mysql -V" | grep "10.6"

# mariadb-10-6 should be version 10.6 server
docker-compose exec -T mariadb-10-6 sh -c "mysql -e \'SHOW variables;\'" | grep "version" | grep "10.6"

# mariadb-10-6 should use default credentials
docker-compose exec -T mariadb-10-6 sh -c "mysql -D lagoon -u lagoon --password=lagoon -e \'SHOW databases;\'" | grep lagoon

# mariadb-10-6 should be able to read/write data
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/mariadb-10-6" | grep "SERVICE_HOST=10.6"
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/mariadb-10-6" | grep "LAGOON_TEST_VAR=all-images"

# mariadb-10-11 should be version 10.11 client
docker-compose exec -T mariadb-10-11 sh -c "mysql -V" | grep "10.11"

# mariadb-10-11 should be version 10.11 server
docker-compose exec -T mariadb-10-11 sh -c "mysql -e \'SHOW variables;\'" | grep "version" | grep "10.11"

# mariadb-10-11 should use default credentials
docker-compose exec -T mariadb-10-11 sh -c "mysql -D lagoon -u lagoon --password=lagoon -e \'SHOW databases;\'" | grep lagoon

# mariadb-10-11 should be able to read/write data
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/mariadb-10-11" | grep "SERVICE_HOST=10.11"
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/mariadb-10-11" | grep "LAGOON_TEST_VAR=all-images"

# mongo-4 should be version 4.0 client
docker-compose exec -T mongo-4 sh -c "mongo --version" | grep "shell version" | grep "v4.0"

# mongo-4 should be version 4.0 server
docker-compose exec -T mongo-4 sh -c "mongo --eval \'printjson(db.serverStatus())\'" | grep "server version" | grep "4.0"

# mongo-4 should have test database
docker-compose exec -T mongo-4 sh -c "mongo --eval \'db.stats()\'" | grep "db" | grep "test"

# mongo-4 should be able to read/write data
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/mongo-4" | grep "SERVICE_HOST="
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/mongo-4" | grep "LAGOON_TEST_VAR=all"

# postgres-11 should be version 11 client
docker-compose exec -T postgres-11 bash -c "psql --version" | grep "psql" | grep "11."

# postgres-11 should be version 11 server
docker-compose exec -T postgres-11 bash -c "psql -U lagoon -d lagoon -c \'SELECT version();\'" | grep "PostgreSQL" | grep "11."

# postgres-11 should have lagoon database
docker-compose exec -T postgres-11 bash -c "psql -U lagoon -d lagoon -c \'\\l+ lagoon\'" | grep "lagoon"

# postgres-11 should be able to read/write data
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/postgres-11" | grep "SERVICE_HOST=PostgreSQL 11"
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/postgres-11" | grep "LAGOON_TEST_VAR=all-images"

# postgres-12 should be version 12 client
docker-compose exec -T postgres-12 bash -c "psql --version" | grep "psql" | grep "12."

# postgres-12 should be version 12 server
docker-compose exec -T postgres-12 bash -c "psql -U lagoon -d lagoon -c \'SELECT version();\'" | grep "PostgreSQL" | grep "12."

# postgres-12 should have lagoon database
docker-compose exec -T postgres-12 bash -c "psql -U lagoon -d lagoon -c \'\\l+ lagoon\'" | grep "lagoon"

# postgres-12 should be able to read/write data
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/postgres-12" | grep "SERVICE_HOST=PostgreSQL 12"
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/postgres-12" | grep "LAGOON_TEST_VAR=all-images"

# postgres-13 should be version 13 client
docker-compose exec -T postgres-13 bash -c "psql --version" | grep "psql" | grep "13."

# postgres-13 should be version 13 server
docker-compose exec -T postgres-13 bash -c "psql -U lagoon -d lagoon -c \'SELECT version();\'" | grep "PostgreSQL" | grep "13."

# postgres-13 should have lagoon database
docker-compose exec -T postgres-13 bash -c "psql -U lagoon -d lagoon -c \'\\l+ lagoon\'" | grep "lagoon"

# postgres-13 should be able to read/write data
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/postgres-13" | grep "SERVICE_HOST=PostgreSQL 13"
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/postgres-13" | grep "LAGOON_TEST_VAR=all-images"

# postgres-14 should be version 14 client
docker-compose exec -T postgres-14 bash -c "psql --version" | grep "psql" | grep "14."

# postgres-14 should be version 14 server
docker-compose exec -T postgres-14 bash -c "psql -U lagoon -d lagoon -c \'SELECT version();\'" | grep "PostgreSQL" | grep "14."

# postgres-14 should have lagoon database
docker-compose exec -T postgres-14 bash -c "psql -U lagoon -d lagoon -c \'\\l+ lagoon\'" | grep "lagoon"

# postgres-14 should be able to read/write data
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/postgres-14" | grep "SERVICE_HOST=PostgreSQL 14"
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/postgres-14" | grep "LAGOON_TEST_VAR=all-images"

# postgres-15 should be version 15 client
docker-compose exec -T postgres-15 bash -c "psql --version" | grep "psql" | grep "15."

# postgres-15 should be version 15 client
docker-compose exec -T postgres-15 bash -c "psql --version" | grep "psql" | grep "15."

# postgres-15 should be version 15 server
docker-compose exec -T postgres-15 bash -c "psql -U lagoon -d lagoon -c \'SELECT version();\'" | grep "PostgreSQL" | grep "15."

# postgres-15 should have lagoon database
docker-compose exec -T postgres-15 bash -c "psql -U lagoon -d lagoon -c \'\\l+ lagoon\'" | grep "lagoon"

# postgres-15 should be able to read/write data
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/postgres-15" | grep "SERVICE_HOST=PostgreSQL 15"
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/postgres-15" | grep "LAGOON_TEST_VAR=all-images"

# PHP 8.0 development should have PHP installed
docker-compose exec -T commons sh -c "curl -kL http://php-8-0-dev:9000" | grep "PHP Version" | grep "8.0"
docker-compose exec -T php-8-0-dev bash -c "php -i" | grep "PHP Version" | grep "8.0"

# PHP 8.0 development should have modules enabled
docker-compose exec -T commons sh -c "curl -kL http://php-8-0-dev:9000" | grep "APCu Support" | grep "Enabled"
docker-compose exec -T commons sh -c "curl -kL http://php-8-0-dev:9000" | grep "LibYAML Support" | grep "enabled"
docker-compose exec -T commons sh -c "curl -kL http://php-8-0-dev:9000" | grep "Redis Support" | grep "enabled"
docker-compose exec -T commons sh -c "curl -kL http://php-8-0-dev:9000" | grep "imagick module" | grep "enabled"

# PHP 8.0 development should have default configuration.
docker-compose exec -T commons sh -c "curl -kL http://php-8-0-dev:9000" | grep "memory_limit" | grep "400M"
docker-compose exec -T commons sh -c "curl -kL http://php-8-0-dev:9000" | grep "short_open_tag" | grep "On"
docker-compose exec -T commons sh -c "curl -kL http://php-8-0-dev:9000" | grep "max_execution_time" | grep "900"
docker-compose exec -T commons sh -c "curl -kL http://php-8-0-dev:9000" | grep "max_input_time" | grep "900"
docker-compose exec -T commons sh -c "curl -kL http://php-8-0-dev:9000" | grep "post_max_size" | grep "2048M"
docker-compose exec -T commons sh -c "curl -kL http://php-8-0-dev:9000" | grep "max_input_vars" | grep "2000"
docker-compose exec -T commons sh -c "curl -kL http://php-8-0-dev:9000" | grep "max_file_uploads" | grep "20"
docker-compose exec -T commons sh -c "curl -kL http://php-8-0-dev:9000" | grep "session.cookie_samesite" | grep "None"
docker-compose exec -T commons sh -c "curl -kL http://php-8-0-dev:9000" | grep "display_errors" | grep "Off"
docker-compose exec -T commons sh -c "curl -kL http://php-8-0-dev:9000" | grep "date.timezone" | grep "UTC"
docker-compose exec -T commons sh -c "curl -kL http://php-8-0-dev:9000" | grep "opcache.memory_consumption" | grep "256"
docker-compose exec -T commons sh -c "curl -kL http://php-8-0-dev:9000" | grep "error_reporting" | grep "22527"
docker-compose exec -T php-8-0-dev bash -c "php -i" | grep "sendmail_path" | grep "/usr/sbin/sendmail -t -i"

# PHP 8.0 development should have extensions enabled.
docker-compose exec -T commons sh -c "curl -kL http://php-8-0-dev:9000" | grep "xdebug.client_port" | grep "9003"
docker-compose exec -T commons sh -c "curl -kL http://php-8-0-dev:9000" | grep "PHP_IDE_CONFIG" | grep "serverName=lagoon"
docker-compose exec -T commons sh -c "curl -kL http://php-8-0-dev:9000" | grep "xdebug.log" | grep "/tmp/xdebug.log"
docker-compose exec -T commons sh -c "curl -kL http://php-8-0-dev:9000" | grep "newrelic.appname" | grep "noproject-nobranch"
docker-compose exec -T commons sh -c "curl -kL http://php-8-0-dev:9000" | grep "newrelic.logfile" | grep "/dev/stderr"
docker-compose exec -T commons sh -c "curl -kL http://php-8-0-dev:9000" | grep "Blackfire" | grep "enabled"
docker-compose exec -T commons sh -c "curl -kL http://php-8-0-dev:9000" | grep "blackfire.agent_socket" | grep "tcp://127.0.0.1:8307"

# PHP 8.0 production should have overridden configuration.
docker-compose exec -T commons sh -c "curl -kL http://php-8-0-prod:9000" | grep "max_input_vars" | grep "4000"
docker-compose exec -T commons sh -c "curl -kL http://php-8-0-prod:9000" | grep "max_file_uploads" | grep "40"
docker-compose exec -T commons sh -c "curl -kL http://php-8-0-prod:9000" | grep "session.cookie_samesite" | grep "Strict"
docker-compose exec -T commons sh -c "curl -kL http://php-8-0-prod:9000" | grep "upload_max_filesize" | grep "1024M"
docker-compose exec -T commons sh -c "curl -kL http://php-8-0-prod:9000" | grep "error_reporting" | grep "22519"

# PHP 8.1 development should have PHP installed
docker-compose exec -T commons sh -c "curl -kL http://php-8-1-dev:9000" | grep "PHP Version" | grep "8.1"
docker-compose exec -T php-8-1-dev bash -c "php -i" | grep "PHP Version" | grep "8.1"

# PHP 8.1 development should have modules enabled
docker-compose exec -T commons sh -c "curl -kL http://php-8-1-dev:9000" | grep "APCu Support" | grep "Enabled"
docker-compose exec -T commons sh -c "curl -kL http://php-8-1-dev:9000" | grep "LibYAML Support" | grep "enabled"
docker-compose exec -T commons sh -c "curl -kL http://php-8-1-dev:9000" | grep "Redis Support" | grep "enabled"
docker-compose exec -T commons sh -c "curl -kL http://php-8-1-dev:9000" | grep "imagick module" | grep "enabled"

# PHP 8.1 development should have default configuration.
docker-compose exec -T commons sh -c "curl -kL http://php-8-1-dev:9000" | grep "memory_limit" | grep "400M"
docker-compose exec -T commons sh -c "curl -kL http://php-8-1-dev:9000" | grep "short_open_tag" | grep "On"
docker-compose exec -T commons sh -c "curl -kL http://php-8-1-dev:9000" | grep "max_execution_time" | grep "900"
docker-compose exec -T commons sh -c "curl -kL http://php-8-1-dev:9000" | grep "max_input_time" | grep "900"
docker-compose exec -T commons sh -c "curl -kL http://php-8-1-dev:9000" | grep "post_max_size" | grep "2048M"
docker-compose exec -T commons sh -c "curl -kL http://php-8-1-dev:9000" | grep "max_input_vars" | grep "2000"
docker-compose exec -T commons sh -c "curl -kL http://php-8-1-dev:9000" | grep "max_file_uploads" | grep "20"
docker-compose exec -T commons sh -c "curl -kL http://php-8-1-dev:9000" | grep "session.cookie_samesite" | grep "None"
docker-compose exec -T commons sh -c "curl -kL http://php-8-1-dev:9000" | grep "display_errors" | grep "Off"
docker-compose exec -T commons sh -c "curl -kL http://php-8-1-dev:9000" | grep "date.timezone" | grep "UTC"
docker-compose exec -T commons sh -c "curl -kL http://php-8-1-dev:9000" | grep "opcache.memory_consumption" | grep "256"
docker-compose exec -T commons sh -c "curl -kL http://php-8-1-dev:9000" | grep "error_reporting" | grep "22527"
docker-compose exec -T php-8-1-dev bash -c "php -i" | grep "sendmail_path" | grep "/usr/sbin/sendmail -t -i"

# PHP 8.1 development should have extensions enabled.
docker-compose exec -T commons sh -c "curl -kL http://php-8-1-dev:9000" | grep "xdebug.client_port" | grep "9003"
docker-compose exec -T commons sh -c "curl -kL http://php-8-1-dev:9000" | grep "PHP_IDE_CONFIG" | grep "serverName=lagoon"
docker-compose exec -T commons sh -c "curl -kL http://php-8-1-dev:9000" | grep "xdebug.log" | grep "/tmp/xdebug.log"
docker-compose exec -T commons sh -c "curl -kL http://php-8-1-dev:9000" | grep "newrelic.appname" | grep "noproject-nobranch"
docker-compose exec -T commons sh -c "curl -kL http://php-8-1-dev:9000" | grep "newrelic.logfile" | grep "/dev/stderr"
docker-compose exec -T commons sh -c "curl -kL http://php-8-1-dev:9000" | grep "Blackfire" | grep "enabled"
docker-compose exec -T commons sh -c "curl -kL http://php-8-1-dev:9000" | grep "blackfire.agent_socket" | grep "tcp://127.0.0.1:8307"

# PHP 8.1 production should have overridden configuration.
docker-compose exec -T commons sh -c "curl -kL http://php-8-1-prod:9000" | grep "max_input_vars" | grep "4000"
docker-compose exec -T commons sh -c "curl -kL http://php-8-1-prod:9000" | grep "max_file_uploads" | grep "40"
docker-compose exec -T commons sh -c "curl -kL http://php-8-1-prod:9000" | grep "session.cookie_samesite" | grep "Strict"
docker-compose exec -T commons sh -c "curl -kL http://php-8-1-prod:9000" | grep "upload_max_filesize" | grep "1024M"
docker-compose exec -T commons sh -c "curl -kL http://php-8-1-prod:9000" | grep "error_reporting" | grep "22519"

# PHP 8.2 development should have PHP installed
docker-compose exec -T commons sh -c "curl -kL http://php-8-2-dev:9000" | grep "PHP Version" | grep "8.2"
docker-compose exec -T php-8-2-dev bash -c "php -i" | grep "PHP Version" | grep "8.2"

# PHP 8.2 development should have modules enabled
docker-compose exec -T commons sh -c "curl -kL http://php-8-2-dev:9000" | grep "APCu Support" | grep "Enabled"
docker-compose exec -T commons sh -c "curl -kL http://php-8-2-dev:9000" | grep "LibYAML Support" | grep "enabled"
docker-compose exec -T commons sh -c "curl -kL http://php-8-2-dev:9000" | grep "Redis Support" | grep "enabled"
docker-compose exec -T commons sh -c "curl -kL http://php-8-2-dev:9000" | grep "imagick module" | grep "enabled"

# PHP 8.2 development should have default configuration.
docker-compose exec -T commons sh -c "curl -kL http://php-8-2-dev:9000" | grep "memory_limit" | grep "400M"
docker-compose exec -T commons sh -c "curl -kL http://php-8-2-dev:9000" | grep "short_open_tag" | grep "On"
docker-compose exec -T commons sh -c "curl -kL http://php-8-2-dev:9000" | grep "max_execution_time" | grep "900"
docker-compose exec -T commons sh -c "curl -kL http://php-8-2-dev:9000" | grep "max_input_time" | grep "900"
docker-compose exec -T commons sh -c "curl -kL http://php-8-2-dev:9000" | grep "post_max_size" | grep "2048M"
docker-compose exec -T commons sh -c "curl -kL http://php-8-2-dev:9000" | grep "max_input_vars" | grep "2000"
docker-compose exec -T commons sh -c "curl -kL http://php-8-2-dev:9000" | grep "max_file_uploads" | grep "20"
docker-compose exec -T commons sh -c "curl -kL http://php-8-2-dev:9000" | grep "session.cookie_samesite" | grep "None"
docker-compose exec -T commons sh -c "curl -kL http://php-8-2-dev:9000" | grep "display_errors" | grep "Off"
docker-compose exec -T commons sh -c "curl -kL http://php-8-2-dev:9000" | grep "date.timezone" | grep "UTC"
docker-compose exec -T commons sh -c "curl -kL http://php-8-2-dev:9000" | grep "opcache.memory_consumption" | grep "256"
docker-compose exec -T commons sh -c "curl -kL http://php-8-2-dev:9000" | grep "error_reporting" | grep "22527"
docker-compose exec -T php-8-2-dev bash -c "php -i" | grep "sendmail_path" | grep "/usr/sbin/sendmail -t -i"

# PHP 8.2 development should have extensions enabled.
docker-compose exec -T commons sh -c "curl -kL http://php-8-2-dev:9000" | grep "xdebug.client_port" | grep "9003"
docker-compose exec -T commons sh -c "curl -kL http://php-8-2-dev:9000" | grep "PHP_IDE_CONFIG" | grep "serverName=lagoon"
docker-compose exec -T commons sh -c "curl -kL http://php-8-2-dev:9000" | grep "xdebug.log" | grep "/tmp/xdebug.log"
docker-compose exec -T commons sh -c "curl -kL http://php-8-2-dev:9000" | grep "newrelic.appname" | grep "noproject-nobranch"
docker-compose exec -T commons sh -c "curl -kL http://php-8-2-dev:9000" | grep "newrelic.logfile" | grep "/dev/stderr"
docker-compose exec -T commons sh -c "curl -kL http://php-8-2-dev:9000" | grep "Blackfire" | grep "enabled"
docker-compose exec -T commons sh -c "curl -kL http://php-8-2-dev:9000" | grep "blackfire.agent_socket" | grep "tcp://127.0.0.1:8307"

# PHP 8.2 production should have overridden configuration.
docker-compose exec -T commons sh -c "curl -kL http://php-8-2-prod:9000" | grep "max_input_vars" | grep "4000"
docker-compose exec -T commons sh -c "curl -kL http://php-8-2-prod:9000" | grep "max_file_uploads" | grep "40"
docker-compose exec -T commons sh -c "curl -kL http://php-8-2-prod:9000" | grep "session.cookie_samesite" | grep "Strict"
docker-compose exec -T commons sh -c "curl -kL http://php-8-2-prod:9000" | grep "upload_max_filesize" | grep "1024M"
docker-compose exec -T commons sh -c "curl -kL http://php-8-2-prod:9000" | grep "error_reporting" | grep "22519"

# varnish-6 should have correct vmods in varnish folder
docker-compose exec -T varnish-6 sh -c "ls -la /usr/lib/varnish/vmods" | grep libvmod_bodyaccess.so
docker-compose exec -T varnish-6 sh -c "ls -la /usr/lib/varnish/vmods" | grep libvmod_dynamic.so

# varnish-6 should be serving pages as version 6
docker-compose exec -T commons sh -c "curl -I varnish-6:8080" | grep "Varnish" | grep "6."

# varnish-7 should have correct vmods in varnish folder
docker-compose exec -T varnish-7 sh -c "ls -la /usr/lib/varnish/vmods" | grep libvmod_bodyaccess.so
docker-compose exec -T varnish-7 sh -c "ls -la /usr/lib/varnish/vmods" | grep libvmod_dynamic.so

# varnish-7 should be serving pages as version 7
docker-compose exec -T commons sh -c "curl -I varnish-7:8080" | grep "Varnish" | grep "7."
docker-compose exec -T varnish-7 sh -c "varnishlog -d" | grep User-Agent | grep curl 

# python-3-7 should be version 3.7
docker-compose exec -T python-3-7 sh -c "python -V" | grep "3.7"

# python-3-7 should have basic tools installed
docker-compose exec -T python-3-7 sh -c "pip list --no-cache-dir" | grep "pip"
docker-compose exec -T python-3-7 sh -c "pip list --no-cache-dir" | grep "setuptools"
docker-compose exec -T python-3-7 sh -c "pip list --no-cache-dir" | grep "virtualenv" | grep "16.7.10"

# python-3-7 should be serving content
docker-compose exec -T commons sh -c "curl python-3-7:3000/tmp/test" | grep "Python 3.7"

# python-3-8 should be version 3.8
docker-compose exec -T python-3-8 sh -c "python -V" | grep "3.8"

# python-3-8 should have basic tools installed
docker-compose exec -T python-3-8 sh -c "pip list --no-cache-dir" | grep "pip"
docker-compose exec -T python-3-8 sh -c "pip list --no-cache-dir" | grep "setuptools"
docker-compose exec -T python-3-8 sh -c "pip list --no-cache-dir" | grep "virtualenv" | grep "16.7.10"

# python-3-8 should be serving content
docker-compose exec -T commons sh -c "curl python-3-8:3000/tmp/test" | grep "Python 3.8"

# python-3-9 should be version 3.9
docker-compose exec -T python-3-9 sh -c "python -V" | grep "3.9"

# python-3-9 should have basic tools installed
docker-compose exec -T python-3-9 sh -c "pip list --no-cache-dir" | grep "pip"
docker-compose exec -T python-3-9 sh -c "pip list --no-cache-dir" | grep "setuptools"
docker-compose exec -T python-3-9 sh -c "pip list --no-cache-dir" | grep "virtualenv"

# python-3-9 should be serving content
docker-compose exec -T commons sh -c "curl python-3-9:3000/tmp/test" | grep "Python 3.9"

# python-3-10 should be version 3.10
docker-compose exec -T python-3-10 sh -c "python -V" | grep "3.10"

# python-3-10 should have basic tools installed
docker-compose exec -T python-3-10 sh -c "pip list --no-cache-dir" | grep "pip"
docker-compose exec -T python-3-10 sh -c "pip list --no-cache-dir" | grep "setuptools"
docker-compose exec -T python-3-10 sh -c "pip list --no-cache-dir" | grep "virtualenv"

# python-3-10 should be serving content
docker-compose exec -T commons sh -c "curl python-3-10:3000/tmp/test" | grep "Python 3.10"

# python-3-11 should be version 3.11
docker-compose exec -T python-3-11 sh -c "python -V" | grep "3.11"

# python-3-10 should have basic tools installed
docker-compose exec -T python-3-11 sh -c "pip list --no-cache-dir" | grep "pip"
docker-compose exec -T python-3-11 sh -c "pip list --no-cache-dir" | grep "setuptools"
docker-compose exec -T python-3-11 sh -c "pip list --no-cache-dir" | grep "virtualenv"

# python-3-10 should be serving content
docker-compose exec -T commons sh -c "curl python-3-11:3000/tmp/test" | grep "Python 3.11"

# node-16 should have Node 16
docker-compose exec -T node-16 sh -c "node -v" | grep "v16"

# node-16 should be serving content
docker-compose exec -T commons sh -c "curl node-16:3000/test" | grep "v16"

# node-18 should have Node 18
docker-compose exec -T node-18 sh -c "node -v" | grep "v18"

# node-18 should be serving content
docker-compose exec -T commons sh -c "curl node-18:3000/test" | grep "v18"

# node-20 should have Node 20
docker-compose exec -T node-20 sh -c "node -v" | grep "v20"

# node-20 should be serving content
docker-compose exec -T commons sh -c "curl node-20:3000/test" | grep "v20"

# ruby-3-0 should have Ruby 3.0
docker-compose exec -T ruby-3-0 sh -c "ruby -v" | grep "3.0"

# ruby-3-0 should be serving content
docker-compose exec -T commons sh -c "curl ruby-3-0:3000/tmp/" | grep "ruby 3.0"

# ruby-3-1 should have Ruby 3.1
docker-compose exec -T ruby-3-1 sh -c "ruby -v" | grep "3.1"

# ruby-3-1 should be serving content
docker-compose exec -T commons sh -c "curl ruby-3-1:3000/tmp/" | grep "ruby 3.1"

# ruby-3-2 should have Ruby 3.2
docker-compose exec -T ruby-3-2 sh -c "ruby -v" | grep "3.2"

# ruby-3-2 should be serving content
docker-compose exec -T commons sh -c "curl ruby-3-2:3000/tmp/" | grep "ruby 3.2"

# opensearch-2 should have opensearch 2
docker-compose exec -T commons sh -c "curl opensearch-2:9200" | grep number | grep "2."

# opensearch-2 should be healthy
docker-compose exec -T commons sh -c "curl opensearch-2:9200/_cluster/health" | json_pp | grep status | grep green

# opensearch-2 should be able to read/write data
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/opensearch-2" | grep "SERVICE_HOST=opensearch-2"
docker-compose exec -T commons sh -c "curl -kL http://internal-services-test:3000/opensearch-2" | grep "LAGOON_TEST_VAR=all"
```

Destroy tests
-------------

Run the following commands to trash this app like nothing ever happened.

```bash
# should be able to destroy our services with success
docker-compose down --volumes --remove-orphans
```
