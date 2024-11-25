#/bin/bash

owner="d-beezee"
repo="grimoar"
workflow_id="unsigned.yml"

RUNS=$(curl  "https://api.github.com/repos/$owner/$repo/actions/workflows/$workflow_id/runs?status=success&per_page=1")

run_id=$(echo $RUNS | jq -r '.workflow_runs[0].id')

# Ottieni gli artifact per la run
RUN=$(curl "https://api.github.com/repos/$owner/$repo/actions/runs/$run_id/artifacts")

artifact_id=$(echo $RUN | jq -r '.artifacts[0].id')

# Scarica uno specifico artifact
curl -L -H "Authorization: token $TOKEN" \
"https://api.github.com/repos/$owner/$repo/actions/artifacts/$artifact_id/zip" \
--output artifact.zip

unzip -o artifact.zip
rm artifact.zip
