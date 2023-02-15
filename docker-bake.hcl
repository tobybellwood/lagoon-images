# docker-bake.dev.hcl
group "default" {
  targets = [
    "commons", 
    "mariadb-10-4",
    "mariadb-10-4-drupal",
    "redis-6",
    "redis-6-persistent",
    "php-8-1-fpm",
    "php-8-1-cli",
    "php-8-1-cli-drupal"
  ]
}

target "commons" {
  context = "images/commons"
  dockerfile = "Dockerfile"
  tags = ["ghcr.io/tobybellwood/commons:bake"]
  platforms = ["linux/amd64", "linux/arm64"]
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
