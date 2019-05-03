FROM python:2.7-alpine
ENV ANSIBLE_LOCAL_TEMP /tmp
RUN apk update && \
    apk add --no-cache --virtual .build-deps make gcc libc-dev openssl-dev python-dev libffi-dev && \
 		pip install ansible-lint && \
    runDeps="$( \
      scanelf --needed --nobanner --recursive /usr/local \
      | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
      | sort -u \
      | xargs -r apk info --installed \
      | sort -u \
    )" && \
    apk add --no-cache --virtual .ansible-lint-rundeps $runDeps && \
    apk del .build-deps && \
    rm -rf ~/.cache/ /var/cache/apk/*
WORKDIR /home/ansible-lint
ENTRYPOINT ["/usr/local/bin/ansible-lint"]
CMD ["--help"]
