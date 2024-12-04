#!/bin/bash
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
set -e

docker build -t ros_docker ${ROOT_DIR}
