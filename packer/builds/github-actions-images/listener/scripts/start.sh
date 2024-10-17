#!/bin/bash

# This script initializes environment variables for a GitHub Actions runner.
#
# Environment Variables:
# - REPOSITORY: The GitHub repository to which the runner will be connected.
# - ACCESS_TOKEN: The access token used for authentication with the GitHub API.
# - RUNNER_NAME: The name assigned to the runner. Defaults to 'nomad-actions-listener' if not provided.
# - RUNNER_LABELS: The labels assigned to the runner. Defaults to 'listener' if not provided.

REPOSITORY=$REPO
ACCESS_TOKEN=$TOKEN
RUNNER_NAME=${NAME:-nomad-actions-listener}
RUNNER_LABELS=${LABELS:-listener}

echo "REPOSITORY: $REPOSITORY"
echo "RUNNERNAME: $RUNNER_NAME"

# This script retrieves a GitHub Actions self-hosted runner registration token for a specified repository.
# It sends a POST request to the GitHub API with the provided access token to generate the registration token.
# The token is then extracted from the JSON response using jq and stored in the REG_TOKEN variable.
#
# Environment Variables:
#   ACCESS_TOKEN - A GitHub personal access token with appropriate permissions.
#   REPOSITORY   - The full name of the repository (e.g., owner/repo).
REG_TOKEN=$(curl -X POST -H "Authorization: token ${ACCESS_TOKEN}" -H "Accept: application/vnd.github+json" https://api.github.com/repos/${REPOSITORY}/actions/runners/registration-token | jq .token --raw-output)

cd /home/runner/actions-runner

# This script registers the GitHub Actions runner with the specified configuration.
# It sources the configuration from 'config.sh' and passes several parameters:
# - --url: The URL of the GitHub repository.
# - --name: The name of the runner.
# - --labels: The labels assigned to the runner.
# - --token: The registration token for the runner.
# - --unattended: Runs the script in unattended mode.
# - --ephemeral: Configures the runner to be ephemeral.
./config.sh --url https://github.com/${REPOSITORY} --name ${RUNNER_NAME} --labels ${RUNNER_LABELS} --token ${REG_TOKEN} --unattended --ephemeral

# This script defines a cleanup function that removes a GitHub Actions runner.
# The function echoes a message indicating the removal of the runner and then
# executes the config.sh script with the remove option in unattended mode,
# using the provided registration token (REG_TOKEN).
cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token ${REG_TOKEN}
}

# This script sets a trap to call the 'cleanup' function when the script exits.
trap 'cleanup' EXIT

# This script starts the run.sh script in the background and waits for it to complete.
./run.sh &
wait $!
