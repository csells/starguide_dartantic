# Starguide

A full-stack application built with Serverpod, featuring a Dart server backend
and Flutter frontend.

This is a port of the original [Serverpod
Starguide](https://github.com/serverpod/starguide) that has been updated to use
the [dartantic_ai](https://pub.dev/packages/dartantic_ai) package for AI model
integration.

## Benefits of Dartantic AI

By using dartantic_ai, this application gains the ability to switch between
multiple providers (OpenAI, Google Gemini, etc.) with a single line of code
change and without rewriting API integration code.

For more details on dartantic_ai capabilities, see the [package
documentation](https://pub.dev/packages/dartantic_ai).

## Architecture

This project consists of three main components:

- **Server** - Serverpod backend server with Postgres and Redis dependencies
- **Client** - Generated Serverpod client library for API communication  
- **Flutter App** - Cross-platform Flutter frontend application

## Quick Start

1. Start the databases and server (see [server
   README](starguide_server/README.md) for details)
2. Run the Flutter app (see [Flutter README](starguide_flutter/README.md) for
   details)
