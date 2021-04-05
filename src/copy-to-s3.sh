#!/usr/bin/env bash

set -o nounset
#set -o errexit
#set -o pipefail
set -o xtrace

# S3_DIRECTORY (to crawl) and S3_TARGET (where to put it) must be specified
#
# requires awscli and wget
# AWS_* should be specified

: ${S3_DIRECTORY}:?"S3_DIRECTORY must be set"
: ${S3_TARGET}:?"S3_TARGET must be set"

readonly S3_DIRECTORY=${S3_DIRECTORY}
readonly S3_TARGET=${S3_TARGET}

aws s3 cp ${S3_DIRECTORY} ${S3_TARGET} --recursive
