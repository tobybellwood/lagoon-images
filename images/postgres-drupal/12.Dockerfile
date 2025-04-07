ARG IMAGE_REPO
FROM ${IMAGE_REPO:-lagoon}/postgres-12

ARG LAGOON_VERSION
ENV LAGOON_VERSION=$LAGOON_VERSION
LABEL org.opencontainers.image.authors="The Lagoon Authors"
LABEL org.opencontainers.image.source="https://github.com/uselagoon/lagoon-images/blob/main/images/postgres-drupal/12.Dockerfile"
LABEL org.opencontainers.image.url="https://github.com/uselagoon/lagoon-images"
LABEL org.opencontainers.image.version="${LAGOON_VERSION}"
LABEL org.opencontainers.image.description="PostgreSQL 12 image optimised for Drupal workloads running in Lagoon in production and locally"
LABEL org.opencontainers.image.title="uselagoon/postgres-12-drupal"
LABEL org.opencontainers.image.base.name="docker.io/uselagoon/postgres-12"

LABEL sh.lagoon.image.deprecated.status="endoflife"
LABEL sh.lagoon.image.deprecated.suggested="docker.io/uselagoon/postgres-17-drupal"

# change log_min_error_statement and log_min_messages from `error` to `log` as drupal is prone to cause some errors which are all logged (yes `log` is a less verbose mode than `error`) 
RUN sed -i "s/#log_min_error_statement = error/log_min_error_statement = log/" /usr/local/share/postgresql/postgresql.conf.sample \
    && sed -i "s/#log_min_messages = warning/log_min_messages = log/" /usr/local/share/postgresql/postgresql.conf.sample

ENV POSTGRES_PASSWORD=drupal \
    POSTGRES_USER=drupal \
    POSTGRES_DB=drupal
