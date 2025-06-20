# Dockerfile
FROM postgres:15-alpine

# Omgevingsvariabelen instellen
ENV POSTGRES_DB=chatmemory
ENV POSTGRES_USER=chatuser
ENV POSTGRES_PASSWORD=changeme123

# Poort blootstellen
EXPOSE 5432

# Volume voor persistente data
VOLUME ["/var/lib/postgresql/data"]

# Optioneel: custom initialization scripts
# COPY ./init-scripts/ /docker-entrypoint-initdb.d/
