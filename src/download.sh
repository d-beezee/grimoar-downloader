#/bin/bash

owner="d-beezee"
repo="grimoar"
workflow_id="release.yml"

RUNS=$(curl -H "Authorization: token $TOKEN"   "https://api.github.com/repos/$owner/$repo/actions/workflows/$workflow_id/runs?status=success&per_page=1")

run_id=$(echo $RUNS | jq -r '.workflow_runs[0].id')

# Ottieni gli artifact per la run
RUN=$(curl  -H "Authorization: token $TOKEN" "https://api.github.com/repos/$owner/$repo/actions/runs/$run_id/artifacts")


for archive_download_url in $(echo $RUN | jq -r '.artifacts[].archive_download_url'); do
    
    curl -L -H "Authorization: token $TOKEN" \
    $archive_download_url \
    --output artifact.zip
    unzip -o artifact.zip
    rm artifact.zip
    
done

