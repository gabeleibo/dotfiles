#!/bin/bash

set -eu

echo "Pulling secrets"

keeper download-attachment /github

rm ~/.ssh/github_rsa

mv $(pwd)/github ~/.ssh/github_rsa
chmod 0600 ~/.ssh/github_rsa

echo "Done!"
