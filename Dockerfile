FROM python:3.14.10-alpine3.24
ARG ANSIBLE_LINT_VERSION=26.10.1
ENV ANSIBLE_LOCAL_TEMP=/tmp
RUN apk upgrade && \
    apk add --no-cache --virtual .build-deps make gcc libc-dev openssl-dev python3-dev libffi-dev && \
 		pip3 install "ansible-lint==$ANSIBLE_LINT_VERSION" && \
    runDeps="$( \
      scanelf --needed --nobanner --recursive /usr/local \
      | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
      | sort -u \
      | xargs -r apk info --installed \
      | sort -u \
    )" && \
    apk add --no-cache --virtual .ansible-lint-rundeps $runDeps git && \
    apk del .build-deps && \
    rm -rf ~/.cache/ /var/cache/apk/*
WORKDIR /app
ENTRYPOINT ["/usr/local/bin/ansible-lint"]
CMD ["--help"]
