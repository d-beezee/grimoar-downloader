#/bin/bash

owner="d-beezee"
repo="grimoar"
workflow_id="release.yml"

RUNS=$(curl -H "Authorization: token $TOKEN"  -s "https://api.github.com/repos/$owner/$repo/actions/workflows/$workflow_id/runs?status=success&per_page=1")

run_id=$(echo $RUNS | jq -r '.workflow_runs[0].id')

# Ottieni gli artifact per la run
RUN=$(curl  -H "Authorization: token $TOKEN" -s "https://api.github.com/repos/$owner/$repo/actions/runs/$run_id/artifacts")

version=$(echo $RUN | jq -r '.artifacts[0].created_at')

echo $version