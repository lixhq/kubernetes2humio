#!/bin/sh
set -e

eval "$($(dirname $0)/env.sh)"

echo "--- Build image"
docker build -t $DOCKER_IMAGE fluentd/docker-image/

if [ "$PUSH_IMAGE" == "true" ]; then
  echo "--- Push image"
  docker tag "$DOCKER_IMAGE" "quay.io/lixtech/$REPO:$FULL_VERSION"
  docker push "quay.io/lixtech/$REPO:$FULL_VERSION"
fi;
