ARG IMAGE_REPO
ARG IMAGE_TAG
FROM --platform=linux/amd64 ${IMAGE_REPO:-lagoon}/commons:${IMAGE_TAG:-latest} as commons

# Held at alpine 3.8 to ensure mongodb 3.6
# Only amd64-based images available
FROM --platform=linux/amd64 alpine:3.8

ENV LAGOON=mongo

ARG LAGOON_VERSION
ENV LAGOON_VERSION=$LAGOON_VERSION

COPY --from=commons /lagoon /lagoon
COPY --from=commons /bin/fix-permissions /bin/ep /bin/docker-sleep /bin/wait-for /bin/
COPY --from=commons /sbin/tini /sbin/
COPY --from=commons /home /home

ENV TMPDIR=/tmp \
    TMP=/tmp \
    HOME=/home \
    # When Bash is invoked via `sh` it behaves like the old Bourne Shell and sources a file that is given in `ENV`
    ENV=/home/.bashrc \
    # When Bash is invoked as non-interactive (like `bash -c command`) it sources a file that is given in `BASH_ENV`
    BASH_ENV=/home/.bashrc

RUN apk --no-cache add mongodb

RUN mkdir -p /data/db /data/configdb && \
    fix-permissions /data/db && \
    fix-permissions /data/configdb

VOLUME /data/db
EXPOSE 27017 28017

ENTRYPOINT ["/sbin/tini", "--", "/lagoon/entrypoints.sh"]
CMD [ "mongod", "--bind_ip", "0.0.0.0" ]
