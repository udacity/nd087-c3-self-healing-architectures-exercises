#!/bin/bash

set -e

kubectl set image deployment nginx-rolling nginx=nginx:1.21.1 # this records the update in the image

# Check deployment rollout status every 1 second until complete.
ATTEMPTS=0
ROLLOUT_STATUS_CMD="kubectl rollout status deployment/nginx-rolling -n udacity"
until $ROLLOUT_STATUS_CMD || [ $ATTEMPTS -eq 60 ]; do
  $ROLLOUT_STATUS_CMD
  ATTEMPTS=$((attempts + 1))
  sleep 1
done

echo "Rolling deployment successful!"