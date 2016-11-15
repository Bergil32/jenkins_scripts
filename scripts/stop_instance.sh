#!/bin/bash
set -ex

# Script with defined variables.
source ${WORKSPACE}/ci/scripts/variables.sh

# Stop instance in current workspace.
docker-compose -p ${DOCKER_PROFILE} ${DOCKER_COMPOSE_TEST_INSTANCE} down
