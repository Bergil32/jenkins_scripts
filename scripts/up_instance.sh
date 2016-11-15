#!/bin/bash
set -ex

# Script with defined variables.
source ${WORKSPACE}/ci/scripts/variables.sh

# Set default docker-compose files to be used in a case they haven't been passed on the script start as $1.
DOCKER_COMPOSE=${1:-${DOCKER_COMPOSE_DEFAULT}}

#Create folder for DB dump.
mkdir -p ${DUMP_FOLDER}/

# Copy DB dump and site files.
rsync -rq --delete ${SOURCE_DUMPS_FOLDER}/${DB_DUMP_NAME} ${DUMP_FOLDER}/
rsync -rq --delete ${SOURCE_FILES_FOLDER} ${FILES_FOLDER}/

# Change owner of the dummyfile to Jenkins user.
sudo chown jenkins:jenkins ${DUMMYFILE}

# Stop containers.
sudo docker-compose -p ${DOCKER_PROFILE} ${DOCKER_COMPOSE} down

# Up containers.
sudo docker-compose -p ${DOCKER_PROFILE} ${DOCKER_COMPOSE} up -d

# Wait for DB container to RUN.
sleep ${SLEEP_TIME}

# Import DB, rebuild cache.
sudo docker-compose -p ${DOCKER_PROFILE} ${DOCKER_COMPOSE} exec -T --user www-data php /bin/sh -c "${SITE_BUILD_COMMAND}"
