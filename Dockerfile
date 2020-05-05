FROM hasura/graphql-engine:latest

WORKDIR /hasura

COPY ./migrations ./hasura
COPY ./metadata ./hasura
COPY ./entrypoint.sh ./hasura
COPY ./migrate.sh ./hasura

ENV HASURA_GRAPHQL_ENABLE_CONSOLE="false"
ENV HASURA_GRAPHQL_ENABLED_LOG_TYPES="startup,query-log"
ENV HASURA_GRAPHQL_MIGRATIONS_SERVER_TIMEOUT=60
ENV HASURA_GRAPHQL_SERVER_PORT=8080
ENV HASURA_GRAPHQL_DATABASE_URL=''

ENV ENABLE_MIGRATIONS="false"
ENV ENABLE_CONSOLE="false"

# download the cloudsql proxy binary
RUN chmod +x ./hasura/entrypoint.sh ./hasura/migrate.sh

ENTRYPOINT ["./hasura/entrypoint.sh"]

CMD /bin/env
