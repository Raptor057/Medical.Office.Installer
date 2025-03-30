#!/bin/bash
if [[ "$OSTYPE" == "darwin"* ]]; then
  bash scripts/check_docker_macos.sh
else
  bash scripts/check_docker_linux.sh
fi

docker-compose up -d
