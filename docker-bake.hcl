# docker-bake.dev.hcl
group "default" {
  targets = [
    "commons", 
    "elasticsearch-7",
    "kibana-7",
    "logstash-7",
    "mariadb-10-4",
    "mariadb-10-4-drupal",
    "mariadb-10-5",
    "mariadb-10-5-drupal",
    "mariadb-10-6",
    "mariadb-10-6-drupal",
    "mongo-4",
    "nginx",
    "nginx-drupal",
    "node-14",
    "node-14-builder",
    "node-14-cli",
    "node-16",
    "node-16-builder",
    "node-16-cli",
    "node-18",
    "node-18-builder",
    "node-18-cli",
    "opensearch-2",
    "php-8-0-fpm",
    "php-8-0-cli",
    "php-8-0-cli-drupal",
    "php-8-1-fpm",
    "php-8-1-cli",
    "php-8-1-cli-drupal",
    "php-8-2-fpm",
    "php-8-2-cli",
    "php-8-2-cli-drupal",
    "postgres-11",
    "postgres-11-drupal",
    "postgres-12",
    "postgres-12-drupal",
    "postgres-13",
    "postgres-13-drupal",
    "postgres-14",
    "postgres-14-drupal",
    "postgres-15",
    "postgres-15-drupal",
    "python-3-7",
    "python-3-8",
    "python-3-9",
    "python-3-10",
    "python-3-11",
    "rabbitmq",
    "rabbitmq-cluster",
    "redis-5",
    "redis-5-persistent",
    "redis-6",
    "redis-6-persistent",
    "redis-7",
    "redis-7-persistent",
    "ruby-3-0",
    "ruby-3-1",
    "ruby-3-2",
    "solr-7",
    "solr-7-drupal",
    "solr-8",
    "solr-8-drupal",
    "varnish-6",
    "varnish-6-drupal",
    "varnish-6-persistent",
    "varnish-6-persistent-drupal",
    "varnish-7",
    "varnish-7-drupal",
    "varnish-7-persistent",
    "varnish-7-persistent-drupal"
  ]
}

group "mariadb" {
  targets = [
    "commons", 
    "mariadb-10-4",
    "mariadb-10-4-drupal",
    "mariadb-10-5",
    "mariadb-10-5-drupal",
    "mariadb-10-6",
    "mariadb-10-6-drupal"
  ]
}

group "node" {
  targets = [
    "commons", 
    "node-14",
    "node-14-builder",
    "node-14-cli",
    "node-16",
    "node-16-builder",
    "node-16-cli",
    "node-18",
    "node-18-builder",
    "node-18-cli"
  ]
}

group "php" {
  targets = [
    "commons", 
    "php-8-0-fpm",
    "php-8-0-cli",
    "php-8-0-cli-drupal",
    "php-8-1-fpm",
    "php-8-1-cli",
    "php-8-1-cli-drupal",
    "php-8-2-fpm",
    "php-8-2-cli",
    "php-8-2-cli-drupal"
  ]
}

group "postgres" {
  targets = [
    "commons", 
    "postgres-11",
    "postgres-11-drupal",
    "postgres-12",
    "postgres-12-drupal",
    "postgres-13",
    "postgres-13-drupal",
    "postgres-14",
    "postgres-14-drupal",
    "postgres-15",
    "postgres-15-drupal"
  ]
}

group "python" {
  targets = [
    "commons", 
    "python-3-7",
    "python-3-8",
    "python-3-9",
    "python-3-10",
    "python-3-11"
  ]
}

group "redis" {
  targets = [
    "commons", 
    "redis-5",
    "redis-5-persistent",
    "redis-6",
    "redis-6-persistent",
    "redis-7",
    "redis-7-persistent"
  ]
}

group "ruby" {
  targets = [
    "commons", 
    "ruby-3-0",
    "ruby-3-1",
    "ruby-3-2"
  ]
}

group "solr" {
  targets = [
    "commons", 
    "solr-7",
    "solr-7-drupal",
    "solr-8",
    "solr-8-drupal"
  ]
}

group "varnish" {
  targets = [
    "commons", 
    "varnish-6",
    "varnish-6-drupal",
    "varnish-6-persistent",
    "varnish-6-persistent-drupal",
    "varnish-7",
    "varnish-7-drupal",
    "varnish-7-persistent",
    "varnish-7-persistent-drupal"
  ]
}

group "others" {
  targets =[
    "commons",
    "elasticsearch-7",
    "kibana-7",
    "logstash-7",
    "mongo-4",
    "nginx",
    "nginx-drupal",
    "opensearch-2",
    "rabbitmq",
    "rabbitmq-cluster"
  ]
}

target "commons" {
  context = "images/commons"
  dockerfile = "Dockerfile"
  tags = ["ghcr.io/tobybellwood/commons:bake"]
  platforms = ["linux/amd64","linux/arm64"]
}

target "elasticsearch-7" {
  inherits = ["commons"]
  context = "images/elasticsearch"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "7.Dockerfile"
  tags = ["ghcr.io/tobybellwood/elasticsearch-7:bake"]
}

target "kibana-7" {
  inherits = ["commons"]
  context = "images/kibana"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "7.Dockerfile"
  tags = ["ghcr.io/tobybellwood/kibana-7:bake"]
}

target "logstash-7" {
  inherits = ["commons"]
  context = "images/logstash"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "7.Dockerfile"
  tags = ["ghcr.io/tobybellwood/logstash-7:bake"]
}

target "mariadb-10-4" {
  inherits = ["commons"]
  context = "images/mariadb"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "10.4.Dockerfile"
  tags = ["ghcr.io/tobybellwood/mariadb-10.4:bake"]
}

target "mariadb-10-4-drupal" {
  inherits = ["commons"]
  context = "images/mariadb-drupal"
  contexts = {
    "lagoon/mariadb-10.4": "target:mariadb-10-4"
  }
  dockerfile = "10.4.Dockerfile"
  tags = ["ghcr.io/tobybellwood/mariadb-10.4-drupal:bake"]
}

target "mariadb-10-5" {
  inherits = ["commons"]
  context = "images/mariadb"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "10.5.Dockerfile"
  tags = ["ghcr.io/tobybellwood/mariadb-10.5:bake"]
}

target "mariadb-10-5-drupal" {
  inherits = ["commons"]
  context = "images/mariadb-drupal"
  contexts = {
    "lagoon/mariadb-10.5": "target:mariadb-10-5"
  }
  dockerfile = "10.5.Dockerfile"
  tags = ["ghcr.io/tobybellwood/mariadb-10.5-drupal:bake"]
}

target "mariadb-10-6" {
  inherits = ["commons"]
  context = "images/mariadb"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "10.6.Dockerfile"
  tags = ["ghcr.io/tobybellwood/mariadb-10.6:bake"]
}

target "mariadb-10-6-drupal" {
  inherits = ["commons"]
  context = "images/mariadb-drupal"
  contexts = {
    "lagoon/mariadb-10.6": "target:mariadb-10-6"
  }
  dockerfile = "10.6.Dockerfile"
  tags = ["ghcr.io/tobybellwood/mariadb-10.6-drupal:bake"]
}

target "mongo-4" {
  inherits = ["commons"]
  context = "images/mongo"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "4.Dockerfile"
  tags = ["ghcr.io/tobybellwood/mongo-4:bake"]
}

target "nginx" {
  inherits = ["commons"]
  context = "images/nginx"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "Dockerfile"
  tags = ["ghcr.io/tobybellwood/nginx:bake"]
}

target "nginx-drupal" {
  inherits = ["commons"]
  context = "images/nginx-drupal"
  contexts = {
    "lagoon/nginx": "target:nginx"
  }
  dockerfile = "Dockerfile"
  tags = ["ghcr.io/tobybellwood/nginx:bake"]
}

target "node-14" {
  inherits = ["commons"]
  context = "images/node"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "14.Dockerfile"
  tags = ["ghcr.io/tobybellwood/node-14:bake"]
}

target "node-14-builder" {
  inherits = ["commons"]
  context = "images/node-builder"
  contexts = {
    "lagoon/node-14": "target:node-14"
  }
  dockerfile = "14.Dockerfile"
  tags = ["ghcr.io/tobybellwood/node-14-builder:bake"]
}

target "node-14-cli" {
  inherits = ["commons"]
  context = "images/node-cli"
  contexts = {
    "lagoon/node-14": "target:node-14"
  }
  dockerfile = "14.Dockerfile"
  tags = ["ghcr.io/tobybellwood/node-14-cli:bake"]
}

target "node-16" {
  inherits = ["commons"]
  context = "images/node"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "16.Dockerfile"
  tags = ["ghcr.io/tobybellwood/node-16:bake"]
}

target "node-16-builder" {
  inherits = ["commons"]
  context = "images/node-builder"
  contexts = {
    "lagoon/node-16": "target:node-16"
  }
  dockerfile = "16.Dockerfile"
  tags = ["ghcr.io/tobybellwood/node-16-builder:bake"]
}

target "node-16-cli" {
  inherits = ["commons"]
  context = "images/node-cli"
  contexts = {
    "lagoon/node-16": "target:node-16"
  }
  dockerfile = "16.Dockerfile"
  tags = ["ghcr.io/tobybellwood/node-16-cli:bake"]
}


target "node-18" {
  inherits = ["commons"]
  context = "images/node"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "18.Dockerfile"
  tags = ["ghcr.io/tobybellwood/node-18:bake"]
}

target "node-18-builder" {
  inherits = ["commons"]
  context = "images/node-builder"
  contexts = {
    "lagoon/node-18": "target:node-18"
  }
  dockerfile = "18.Dockerfile"
  tags = ["ghcr.io/tobybellwood/node-18-builder:bake"]
}

target "node-18-cli" {
  inherits = ["commons"]
  context = "images/node-cli"
  contexts = {
    "lagoon/node-18": "target:node-18"
  }
  dockerfile = "18.Dockerfile"
  tags = ["ghcr.io/tobybellwood/node-18-cli:bake"]
}

target "opensearch-2" {
  inherits = ["commons"]
  context = "images/opensearch"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "2.Dockerfile"
  tags = ["ghcr.io/tobybellwood/opensearch-2:bake"]
}

target "php-8-0-fpm" {
  inherits = ["commons"]
  context = "images/php-fpm"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "8.0.Dockerfile"
  tags = ["ghcr.io/tobybellwood/php-8.0-fpm:bake"]
}

target "php-8-0-cli" {
  inherits = ["commons"]
  context = "images/php-cli"
  contexts = {
    "lagoon/php-8.0-fpm": "target:php-8-0-fpm"
  }
  dockerfile = "8.0.Dockerfile"
  tags = ["ghcr.io/tobybellwood/php-8.0-cli:bake"]
}

target "php-8-0-cli-drupal" {
  inherits = ["commons"]
  context = "images/php-cli-drupal"
  contexts = {
    "lagoon/php-8.0-cli": "target:php-8-0-cli"
  }
  dockerfile = "8.0.Dockerfile"
  tags = ["ghcr.io/tobybellwood/php-8.0-cli-drupal:bake"]
}

target "php-8-1-fpm" {
  inherits = ["commons"]
  context = "images/php-fpm"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "8.1.Dockerfile"
  tags = ["ghcr.io/tobybellwood/php-8.1-fpm:bake"]
}

target "php-8-1-cli" {
  inherits = ["commons"]
  context = "images/php-cli"
  contexts = {
    "lagoon/php-8.1-fpm": "target:php-8-1-fpm"
  }
  dockerfile = "8.1.Dockerfile"
  tags = ["ghcr.io/tobybellwood/php-8.1-cli:bake"]
}

target "php-8-1-cli-drupal" {
  inherits = ["commons"]
  context = "images/php-cli-drupal"
  contexts = {
    "lagoon/php-8.1-cli": "target:php-8-1-cli"
  }
  dockerfile = "8.1.Dockerfile"
  tags = ["ghcr.io/tobybellwood/php-8.1-cli-drupal:bake"]
}

target "php-8-2-fpm" {
  inherits = ["commons"]
  context = "images/php-fpm"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "8.2.Dockerfile"
  tags = ["ghcr.io/tobybellwood/php-8.2-fpm:bake"]
}

target "php-8-2-cli" {
  inherits = ["commons"]
  context = "images/php-cli"
  contexts = {
    "lagoon/php-8.2-fpm": "target:php-8-2-fpm"
  }
  dockerfile = "8.2.Dockerfile"
  tags = ["ghcr.io/tobybellwood/php-8.2-cli:bake"]
}

target "php-8-2-cli-drupal" {
  inherits = ["commons"]
  context = "images/php-cli-drupal"
  contexts = {
    "lagoon/php-8.2-cli": "target:php-8-2-cli"
  }
  dockerfile = "8.2.Dockerfile"
  tags = ["ghcr.io/tobybellwood/php-8.2-cli-drupal:bake"]
}

target "postgres-11" {
  inherits = ["commons"]
  context = "images/postgres"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "11.Dockerfile"
  tags = ["ghcr.io/tobybellwood/postgres-11:bake"]
}

target "postgres-11-drupal" {
  inherits = ["commons"]
  context = "images/postgres-drupal"
  contexts = {
    "lagoon/postgres-11": "target:postgres-11"
  }
  dockerfile = "11.Dockerfile"
  tags = ["ghcr.io/tobybellwood/postgres-11-drupal:bake"]
}

target "postgres-11-ckan" {
  inherits = ["commons"]
  context = "images/postgres-ckan"
  contexts = {
    "lagoon/postgres-11": "target:postgres-11"
  }
  dockerfile = "11.Dockerfile"
  tags = ["ghcr.io/tobybellwood/postgres-11-ckan:bake"]
}

target "postgres-12" {
  inherits = ["commons"]
  context = "images/postgres"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "12.Dockerfile"
  tags = ["ghcr.io/tobybellwood/postgres-12:bake"]
}

target "postgres-12-drupal" {
  inherits = ["commons"]
  context = "images/postgres-drupal"
  contexts = {
    "lagoon/postgres-12": "target:postgres-12"
  }
  dockerfile = "12.Dockerfile"
  tags = ["ghcr.io/tobybellwood/postgres-12-drupal:bake"]
}

target "postgres-13" {
  inherits = ["commons"]
  context = "images/postgres"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "13.Dockerfile"
  tags = ["ghcr.io/tobybellwood/postgres-13:bake"]
}

target "postgres-13-drupal" {
  inherits = ["commons"]
  context = "images/postgres-drupal"
  contexts = {
    "lagoon/postgres-13": "target:postgres-13"
  }
  dockerfile = "13.Dockerfile"
  tags = ["ghcr.io/tobybellwood/postgres-13-drupal:bake"]
}

target "postgres-14" {
  inherits = ["commons"]
  context = "images/postgres"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "14.Dockerfile"
  tags = ["ghcr.io/tobybellwood/postgres-14:bake"]
}

target "postgres-14-drupal" {
  inherits = ["commons"]
  context = "images/postgres-drupal"
  contexts = {
    "lagoon/postgres-14": "target:postgres-14"
  }
  dockerfile = "14.Dockerfile"
  tags = ["ghcr.io/tobybellwood/postgres-14-drupal:bake"]
}

target "postgres-15" {
  inherits = ["commons"]
  context = "images/postgres"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "15.Dockerfile"
  tags = ["ghcr.io/tobybellwood/postgres-15:bake"]
}

target "postgres-15-drupal" {
  inherits = ["commons"]
  context = "images/postgres-drupal"
  contexts = {
    "lagoon/postgres-15": "target:postgres-15"
  }
  dockerfile = "15.Dockerfile"
  tags = ["ghcr.io/tobybellwood/postgres-15-drupal:bake"]
}

target "python-3-7" {
  inherits = ["commons"]
  context = "images/python"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "3.7.Dockerfile"
  tags = ["ghcr.io/tobybellwood/python-3.7:bake"]
}

target "python-3-8" {
  inherits = ["commons"]
  context = "images/python"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "3.8.Dockerfile"
  tags = ["ghcr.io/tobybellwood/python-3.8:bake"]
}

target "python-3-9" {
  inherits = ["commons"]
  context = "images/python"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "3.9.Dockerfile"
  tags = ["ghcr.io/tobybellwood/python-3.9:bake"]
}

target "python-3-10" {
  inherits = ["commons"]
  context = "images/python"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "3.10.Dockerfile"
  tags = ["ghcr.io/tobybellwood/python-3.10:bake"]
}

target "python-3-11" {
  inherits = ["commons"]
  context = "images/python"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "3.11.Dockerfile"
  tags = ["ghcr.io/tobybellwood/python-3.11:bake"]
}

target "rabbitmq" {
  inherits = ["commons"]
  context = "images/rabbitmq"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "Dockerfile"
  tags = ["ghcr.io/tobybellwood/rabbitmq:bake"]
}

target "rabbitmq-cluster" {
  inherits = ["commons"]
  context = "images/rabbitmq-cluster"
  contexts = {
    "lagoon/rabbitmq": "target:rabbitmq"
  }
  dockerfile = "Dockerfile"
  tags = ["ghcr.io/tobybellwood/rabbitmq-cluster:bake"]
}

target "redis-5" {
  inherits = ["commons"]
  context = "images/redis"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "5.Dockerfile"
  tags = ["ghcr.io/tobybellwood/redis-5:bake"]
}

target "redis-5-persistent" {
  inherits = ["commons"]
  context = "images/redis-persistent"
  contexts = {
    "lagoon/redis-5": "target:commons"
  }
  dockerfile = "5.Dockerfile"
  tags = ["ghcr.io/tobybellwood/redis-5-persistent:bake"]
}

target "redis-6" {
  inherits = ["commons"]
  context = "images/redis"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "6.Dockerfile"
  tags = ["ghcr.io/tobybellwood/redis-6:bake"]
}

target "redis-6-persistent" {
  inherits = ["commons"]
  context = "images/redis-persistent"
  contexts = {
    "lagoon/redis-6": "target:commons"
  }
  dockerfile = "6.Dockerfile"
  tags = ["ghcr.io/tobybellwood/redis-6-persistent:bake"]
}

target "redis-7" {
  inherits = ["commons"]
  context = "images/redis"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "7.Dockerfile"
  tags = ["ghcr.io/tobybellwood/redis-7:bake"]
}

target "redis-7-persistent" {
  inherits = ["commons"]
  context = "images/redis-persistent"
  contexts = {
    "lagoon/redis-7": "target:commons"
  }
  dockerfile = "7.Dockerfile"
  tags = ["ghcr.io/tobybellwood/redis-7-persistent:bake"]
}

target "ruby-3-0" {
  inherits = ["commons"]
  context = "images/ruby"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "3.0.Dockerfile"
  tags = ["ghcr.io/tobybellwood/ruby-3.0:bake"]
}

target "ruby-3-1" {
  inherits = ["commons"]
  context = "images/ruby"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "3.1.Dockerfile"
  tags = ["ghcr.io/tobybellwood/ruby-3.1:bake"]
}

target "ruby-3-2" {
  inherits = ["commons"]
  context = "images/ruby"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "3.2.Dockerfile"
  tags = ["ghcr.io/tobybellwood/ruby-3.2:bake"]
}

target "solr-7" {
  inherits = ["commons"]
  context = "images/solr"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "7.Dockerfile"
  tags = ["ghcr.io/tobybellwood/solr-7:bake"]
}

target "solr-7-drupal" {
  inherits = ["commons"]
  context = "images/solr-drupal"
  contexts = {
    "lagoon/solr-7": "target:solr-7"
  }
  dockerfile = "7.Dockerfile"
  tags = ["ghcr.io/tobybellwood/solr-7-drupal:bake"]
}

target "solr-8" {
  inherits = ["commons"]
  context = "images/solr"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "8.Dockerfile"
  tags = ["ghcr.io/tobybellwood/solr-8:bake"]
}

target "solr-8-drupal" {
  inherits = ["commons"]
  context = "images/solr-drupal"
  contexts = {
    "lagoon/solr-8": "target:solr-8"
  }
  dockerfile = "8.Dockerfile"
  tags = ["ghcr.io/tobybellwood/solr-8-drupal:bake"]
}

target "varnish-6" {
  inherits = ["commons"]
  context = "images/varnish"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "6.Dockerfile"
  tags = ["ghcr.io/tobybellwood/varnish-6:bake"]
}

target "varnish-6-drupal" {
  inherits = ["commons"]
  context = "images/varnish-drupal"
  contexts = {
    "lagoon/varnish-6": "target:varnish-6"
  }
  dockerfile = "6.Dockerfile"
  tags = ["ghcr.io/tobybellwood/varnish-6-drupal:bake"]
}

target "varnish-6-persistent" {
  inherits = ["commons"]
  context = "images/varnish-persistent"
  contexts = {
    "lagoon/varnish-6": "target:varnish-6"
  }
  dockerfile = "6.Dockerfile"
  tags = ["ghcr.io/tobybellwood/varnish-6-persistent:bake"]
}

target "varnish-6-persistent-drupal" {
  inherits = ["commons"]
  context = "images/varnish-persistent-drupal"
  contexts = {
    "lagoon/varnish-6-drupal": "target:varnish-6-drupal"
  }
  dockerfile = "6.Dockerfile"
  tags = ["ghcr.io/tobybellwood/varnish-6-persistent-drupal:bake"]
}

target "varnish-7" {
  inherits = ["commons"]
  context = "images/varnish"
  contexts = {
    "lagoon/commons": "target:commons"
  }
  dockerfile = "7.Dockerfile"
  tags = ["ghcr.io/tobybellwood/varnish-7:bake"]
}

target "varnish-7-drupal" {
  inherits = ["commons"]
  context = "images/varnish-drupal"
  contexts = {
    "lagoon/varnish-7": "target:varnish-7"
  }
  dockerfile = "7.Dockerfile"
  tags = ["ghcr.io/tobybellwood/varnish-7-drupal:bake"]
}

target "varnish-7-persistent" {
  inherits = ["commons"]
  context = "images/varnish-persistent"
  contexts = {
    "lagoon/varnish-7": "target:varnish-7"
  }
  dockerfile = "7.Dockerfile"
  tags = ["ghcr.io/tobybellwood/varnish-7-persistent:bake"]
}

target "varnish-7-persistent-drupal" {
  inherits = ["commons"]
  context = "images/varnish-persistent-drupal"
  contexts = {
    "lagoon/varnish-7-drupal": "target:varnish-7-drupal"
  }
  dockerfile = "7.Dockerfile"
  tags = ["ghcr.io/tobybellwood/varnish-7-persistent-drupal:bake"]
}
