ARG IMAGE_REPO
ARG IMAGE_TAG
FROM ${IMAGE_REPO:-lagoon}/solr-7:${IMAGE_TAG:-latest}

COPY drupal-4.1.1-solr-7.x-0 /solr-conf

RUN precreate-core drupal /solr-conf

CMD ["solr-foreground"]
