# The db service's image for Kubernetes: Postgres, with the Bounty Board's
# table and first five bounties built in.

# compose.yaml doesn't use this file. Compose lends init.sql to the container
# from your folder. A pod in a cluster can't reach your folder, so for
# Kubernetes, the image carries init.sql instead.
FROM postgres:17-alpine
# Postgres runs every .sql file in this folder once, when it sets up a
# brand-new database.
COPY init.sql /docker-entrypoint-initdb.d/init.sql
