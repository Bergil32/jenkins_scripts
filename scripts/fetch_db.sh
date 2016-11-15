#!/bin/bash
set -ex

# Variables.

# Project name.
PROJECT_NAME="PROJECT_NAME"

# Dump name pattern.
DUMP_NAME="${PROJECT_NAME}--$(date +"%Y-%m-%d_%H-%M-%S").sql.gz"

# Workdir folder of the MAIN_INSTANCE job.
MAIN_INSTANCE_FOLDER="${JENKINS_HOME}/jobs/${PROJECT_NAME}_MAIN_INSTANCE/workspace"

# Name of the docker profile for MAIN_INSTANCE job.
DOCKER_PROFILE="${PROJECT_NAME}_MAIN_INSTANCE"

# Define Docker compose files to be used.
DOCKER_COMPOSE="-f ${MAIN_INSTANCE_FOLDER}/ci/docker-compose.yml -f ${MAIN_INSTANCE_FOLDER}/ci/docker-compose.override.yml"

# Commands.

# Create base dump.
sudo docker-compose -p ${DOCKER_PROFILE} ${DOCKER_COMPOSE} exec -T --user www-data php sh -c "drush sql-dump" | gzip > ${WORKSPACE}/${DUMP_NAME};

# Cleanup workspace. Leave only last N dumps.
cd ${WORKSPACE}/;
N=10;
(ls -t|head -n $N;ls)|sort|uniq -u|xargs --no-run-if-empty rm -rf
