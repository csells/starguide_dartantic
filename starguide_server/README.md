# starguide_server

This is the starting point for your Serverpod server.

To run your server, you first need to start Postgres and Redis. It's easiest to
do with Docker.

    docker compose up --build --detach

This starts the databases in Docker containers, with Postgres on port 8090 and
Redis on port 8091.

You'll also need to create a `config/passwords.yaml` file:

```yaml
# Save passwords used across all configurations here.
shared:
  mySharedPassword: 'my password'
  geminiAPIKey: 'TODO'
  githubToken: 'TODO'
  recaptchaSecretKey: 'TODO'

# These are passwords used when running the server locally in development mode
development:
  database: 'KG3uoH8yvl2TBJGZWYA6Pw5ToPV0FwRP'
  redis: 'cv62dn4dCyCL8NZEWjJYZNDjOKXQzQqH'

  # The service secret is used to communicate between servers and to access the
  # service protocol.
  serviceSecret: '-bqxtPOy79-V1xjYZBm3BX-UzgSFZBlo'

test:
  database: '9mPvLeV-d_p6P8DsoZDhiPB_l_BlvGeq'
  redis: 'xDbf-Z9dVvEZo2iMx2tDMLRbZDsq-Wdq'

# Passwords used in your staging environment if you use one. The default setup
# use a password for Redis.
staging:
  database: 'icekXsg1yYju_XS6fa-y3lrzA0H4ULpu'
  serviceSecret: 'I4Todv2g1xj2r7HMq-t2DkSS45RtPi8r'

# Passwords used in production mode.
production:
  database: 'clrVprd2XfLN-KZDEzVa8XVX4mjcRDI8'
  serviceSecret: '71d7N3Zwfg7vVp3ac69uacSw0SYD8qG9'
```

Then you can start the Serverpod server, which runs locally but connects to the
containerized databases.

    dart bin/main.dart --apply-migrations

When you are finished, you can shut down Serverpod with `Ctrl-C`, then stop
Postgres and Redis.

    docker compose stop
