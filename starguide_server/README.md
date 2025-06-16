# starguide_server

This is the starting point for your Serverpod server.

To run your server, you first need to start Postgres and Redis. It's easiest to
do with Docker.

    docker compose up --build --detach

This starts the databases in Docker containers, with Postgres on port 8090 and
Redis on port 8091.

Then you can start the Serverpod server, which runs locally but connects to the
containerized databases.

    dart bin/main.dart

When you are finished, you can shut down Serverpod with `Ctrl-C`, then stop
Postgres and Redis.

    docker compose stop
