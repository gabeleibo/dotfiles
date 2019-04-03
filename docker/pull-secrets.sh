#!/bin/bash

set -eu

echo "Pulling Keeper Secrets"

keeper download-attachment /github

rm -f ~/.ssh/github_rsa

mv $(pwd)/github ~/.ssh/github_rsa
chmod 0600 ~/.ssh/github_rsa

rm -f $(pwd)/config.json

echo "Docker Login"

docker login -u gabeleibo

echo "Done!"
