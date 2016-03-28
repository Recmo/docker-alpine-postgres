FROM gliderlabs/alpine:3.3

RUN echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    apk update && apk add "postgresql@edge>9.5" && \
    mkdir /docker-entrypoint-initdb.d && \
    rm -rf /var/cache/apk/*

ENV LANG en_US.utf8
ENV PGDATA /var/lib/postgresql/data
VOLUME /var/lib/postgresql/data

COPY docker-entrypoint.sh /

RUN chown -R postgres "$PGDATA" && \
    chown postgres /docker-entrypoint.sh && chmod 755 /docker-entrypoint.sh

USER postgres

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]
