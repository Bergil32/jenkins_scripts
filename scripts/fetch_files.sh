#!/bin/bash
set -ex

# Project name.
PROJECT_NAME="PROJECT_NAME"

# Folder with files to fetch.
FILES_FOLDER="${JENKINS_HOME}/jobs/${PROJECT_NAME}_MAIN_INSTANCE/workspace/drupal8/sites/default/files"

# Command to fetch files.
rsync -rvh --delete ${FILES_FOLDER} ${WORKSPACE}/
