#!/bin/bash

REPOSITORY=$REPO
ACCESS_TOKEN=$TOKEN
RUNNER_NAME=${NAME:-nomad-actions-builder}
RUNNER_LABELS=${LABELS:-builder}

echo "REPOSITORY: $REPOSITORY"
echo "RUNNERNAME: $RUNNER_NAME"

REG_TOKEN=$(curl -X POST -H "Authorization: token ${ACCESS_TOKEN}" -H "Accept: application/vnd.github+json" https://api.github.com/repos/${REPOSITORY}/actions/runners/registration-token | jq .token --raw-output)

cd /home/runner/actions-runner

./config.sh --url https://github.com/${REPOSITORY} --name ${RUNNER_NAME} --labels ${RUNNER_LABELS} --token ${REG_TOKEN} --unattended --ephemeral

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token ${REG_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh &
wait $!
