FROM python:3.13.1-alpine3.21
ARG ANSIBLE_LINT_VERSION=25.1.1
ENV ANSIBLE_LOCAL_TEMP=/tmp
RUN apk upgrade && \
    apk add --no-cache --virtual .build-deps make gcc libc-dev openssl-dev python3-dev libffi-dev && \
 		pip3 install "ansible-lint[community,yamllint]==$ANSIBLE_LINT_VERSION" && \
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
