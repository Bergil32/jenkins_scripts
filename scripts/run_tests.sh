#!/bin/bash
set -ex

# Script with defined variables.
source ${WORKSPACE}/ci/scripts/variables.sh

# Set default Behat options to be used in a case they haven't been passed on the script start as $1.
BEHAT_COMMAND=${1:-${DEFAULT_BEHAT_OPTIONS}}

#Run up instance script and pass $DOCKER_COMPOSE.
bash ${WORKSPACE}/ci/scripts/up_instance.sh "${DOCKER_COMPOSE_TEST_INSTANCE}"

# Run Behat tests.
docker-compose -p ${DOCKER_PROFILE} ${DOCKER_COMPOSE_TEST_INSTANCE} exec -T behat /srv/entrypoint.sh "${BEHAT_COMMAND}"
