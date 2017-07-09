FROM mark-base

ARG POSTGRES_USER
ARG POSTGRES_PASSWORD
ARG POSTGRES_DATABASE

USER root

# explicitly set user/group IDs
RUN groupadd -r postgres --gid=999 && useradd -r -g postgres --uid=999 postgres

# Add PostgreSQL repository
RUN set -x \
  && echo 'deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main' > /etc/apt/sources.list.d/pgdg.list \
  && wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add -

# make the "en_US.UTF-8" locale so postgres will be utf-8 enabled by default
RUN set -x \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.UTF-8

# Install postgreSQL
RUN set -x \
  && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y -q install \
    postgresql-common \
    postgresql-9.5 postgresql-contrib-9.5 libpq-dev \
  && rm -rf /var/lib/apt/lists/*

USER postgres

RUN /etc/init.d/postgresql start \
  && psql --command "ALTER USER postgres WITH SUPERUSER PASSWORD 'postgres';" \
  && psql --command "CREATE USER ${POSTGRES_USER:-mark} WITH SUPERUSER PASSWORD '${POSTGRES_PASSWORD:-mark}';" \
  && createdb -O ${POSTGRES_USER:-mark} ${POSTGRES_DATABASE:-mark}

USER root

# Adjust PostgreSQL configuration to allow remote connections
RUN \
  echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.5/main/pg_hba.conf && \
  echo "listen_addresses='*'" >> /etc/postgresql/9.5/main/postgresql.conf

# Expose the PostgreSQL port
EXPOSE 5432

RUN mkdir -p /var/run/postgresql && chown -R postgres /var/run/postgresql

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

USER postgres

# Set the default command to run when starting the container
CMD ["/usr/lib/postgresql/9.5/bin/postgres", "-D", "/var/lib/postgresql/9.5/main", "-c", "config_file=/etc/postgresql/9.5/main/postgresql.conf"]

# docker build --rm=true -t base-postgres .
