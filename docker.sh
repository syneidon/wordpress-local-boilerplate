#!/bin/bash

set -a
source .env
set +a
docker compose -p "${PROJECT_NAME}" up -d
