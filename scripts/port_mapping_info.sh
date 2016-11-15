#!/bin/bash
set -ex

# Script with defined variables.
source ${WORKSPACE}/ci/scripts/variables.sh

# Create artifacts folder if it does not exist.
mkdir -p ${ARTIFACTS_FOLDER}

# Write port forwarding information to the file.
echo "nginx 443 -> $(${DOCKER_COMPOSE_PORT_CMD} nginx 443)" > ${ARTIFACTS_FOLDER}/port_mapping
echo "nginx 80-> $(${DOCKER_COMPOSE_PORT_CMD} nginx 80)" >> ${ARTIFACTS_FOLDER}/port_mapping
echo "mailhog 8025 -> $(${DOCKER_COMPOSE_PORT_CMD} mailhog 8025)" >> ${ARTIFACTS_FOLDER}/port_mapping
