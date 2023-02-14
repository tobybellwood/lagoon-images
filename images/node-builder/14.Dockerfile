ARG IMAGE_REPO
ARG IMAGE_TAG
FROM ${IMAGE_REPO:-lagoon}/node-14:${IMAGE_TAG:-latest}

ENV LAGOON=node

RUN apk update \
    && apk add --no-cache \
           libstdc++ \
    && apk add --no-cache \
           bash \
           binutils-gold \
           ca-certificates \
           curl \
           file \
           g++ \
           gcc \
           gcompat \
           git \
           gnupg \
           libgcc \
           libpng-dev \
           linux-headers \
           make \
           openssl \
           wget \
    && rm -rf /var/cache/apk/*

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.15/main' >> /etc/apk/repositories \
    && echo 'http://dl-cdn.alpinelinux.org/alpine/v3.15/community' >> /etc/apk/repositories \
    && apk update \
    && apk add \
           python2=~2.7 \
    && rm -rf /var/cache/apk/*

CMD ["/bin/docker-sleep"]
