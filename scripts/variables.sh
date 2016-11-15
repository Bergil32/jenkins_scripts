#!/bin/bash

# Project name.
PROJECT_NAME="PROJECT_NAME"

# Name of the site root folder.
SITE_FOLDER="drupal8"

# Default Behat options to be used.
DEFAULT_BEHAT_OPTIONS="--format=pretty --out=std --format=cucumber_json --out=std";

# Sleep time to give DB container enough time to start.
SLEEP_TIME=30

# Profile name for docker compose.
DOCKER_PROFILE="${JOB_NAME}${pullRequestId}"

# Set the name of the instance stopper name.
INSTANCE_STOPPER_JOB_NAME="${PROJECT_NAME}_INSTANCE_STOPPER"

# Define Docker compose files to be used.
DOCKER_COMPOSE_DEFAULT="-f ${WORKSPACE}/ci/docker-compose.yml -f ${WORKSPACE}/ci/docker-compose.main.yml"
DOCKER_COMPOSE_TEST_INSTANCE="-f ${WORKSPACE}/ci/docker-compose.yml -f ${WORKSPACE}/ci/docker-compose.behat.yml"

# Folder with source DB dumps. Getting name of the last DB dump. Folder where DB dump must be placed.
FETCH_DB_JOB_NAME="${PROJECT_NAME}_FETCH_DB"
SOURCE_DUMPS_FOLDER="${JENKINS_HOME}/jobs/${FETCH_DB_JOB_NAME}/workspace"
DB_DUMP_NAME=$(ls -t ${SOURCE_DUMPS_FOLDER}/ | head -n1);
DUMP_FOLDER="${WORKSPACE}/${SITE_FOLDER}/db_dump"

# Folder with source Files and folder where files must be placed.
FETCH_FILES_JOB_NAME="${PROJECT_NAME}_FETCH_FILES"
SOURCE_FILES_FOLDER="${JENKINS_HOME}/jobs/${FETCH_FILES_JOB_NAME}/workspace/files"
FILES_FOLDER="${WORKSPACE}/${SITE_FOLDER}/sites/default"

# Site build commands.
SITE_BUILD_COMMAND="cd /var/www/html;
drush sql-drop -y;
gunzip < /var/www/html/db_dump/${DB_DUMP_NAME} | drush sql-cli;
drush rebuild;
drush cim -y;
drush updb -y;
drush rebuild;
"

# Path to a dummyfile.
DUMMYFILE="${WORKSPACE}/ci/dummyfile"

# Folder with files to archive.
ARTIFACTS_FOLDER="${WORKSPACE}/tests/behat/artifacts/screenshots"

# Variable for the docker-compose port command.
DOCKER_COMPOSE_PORT_CMD="docker-compose -p ${DOCKER_PROFILE} ${DOCKER_COMPOSE_TEST_INSTANCE} port"
