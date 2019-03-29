#!/bin/bash

set -eu

echo "Authenticating with 1Password"
export OP_SESSION_my=$(op signin https://my.1password.com gabriel.leibovich@gmail.com --output=raw)

echo "Pulling secrets"

op get document 'github_rsa' > github_rsa

rm ~/.ssh/github_rsa

ln -s $(pwd)/github_rsa ~/.ssh/github_rsa
chmod 0600 ~/.ssh/github_rsa

echo "Done!"
