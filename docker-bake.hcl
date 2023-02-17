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
    "redis-6",
    "redis-6-persistent",
    "redis-7",
    "redis-7-persistent",
  ]
}

group "mariadb" {
  targets = [
    "commons", 
    "php-8-0-fpm",
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
    "node-18-cli",
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


target "commons" {
  context = "images/commons"
  dockerfile = "Dockerfile"
  tags = ["ghcr.io/tobybellwood/commons:bake"]
  platforms = ["linux/amd64"]
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
  tags = ["ghcr.io/tobybellwood/mariadb-drupal-10.4:bake"]
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
  tags = ["ghcr.io/tobybellwood/mariadb-drupal-10.5:bake"]
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
  tags = ["ghcr.io/tobybellwood/mariadb-drupal-10.6:bake"]
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
