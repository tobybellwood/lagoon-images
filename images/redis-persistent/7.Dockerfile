ARG IMAGE_REPO
FROM ${IMAGE_REPO:-lagoon}/redis-7

ENV FLAVOR=persistent
