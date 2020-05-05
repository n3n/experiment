FROM hasura/graphql-engine:v1.1.0

WORKDIR /hasura

COPY ./migrations /metadata
COPY ./entrypoint.sh .
COPY ./migrate.sh .

ENV HASURA_GRAPHQL_ENABLE_CONSOLE="false"
ENV HASURA_GRAPHQL_ENABLED_LOG_TYPES="startup,query-log"
ENV HASURA_GRAPHQL_MIGRATIONS_SERVER_TIMEOUT=60
ENV HASURA_GRAPHQL_SERVER_PORT=8080
ENV HASURA_GRAPHQL_DATABASE_URL=''
ENV CLOUDSQL_INSTANCE=''

ENV ENABLE_CLOUDSQL_PROXY="false"
ENV ENABLE_MIGRATIONS="false"
ENV ENABLE_CONSOLE="false"

# download the cloudsql proxy binary
RUN wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O /bin/cloud_sql_proxy
RUN chmod +x /bin/cloud_sql_proxy ./entrypoint.sh ./migrate.sh

ENTRYPOINT ["./entrypoint.sh"]

CMD /bin/env
