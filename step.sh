#!/bin/bash
set -ex

# Change the working dir if necessary
if [ ! -z "${workdir}" ] ; then
    echo "==> switching to react native project root: ${workdir}"
    cd "${workdir}"
    if [ $? -ne 0 ] ; then
        echo " [!] failed to switch to react native project root: ${workdir}"
        exit 1
    fi
fi

if ! which revopush > /dev/null; then
  echo "Installing Revopush CLI..."
  npm install -g @revopush/code-push-cli@$version --force --silent > /dev/null 2>&1
fi

echo "Logging in to Revopush..."
revopush logout > /dev/null 2>&1 || true
revopush login --accessKey $access_key
echo "Execute command..."
revopush $command
revopush logout > /dev/null 2>&1 || true

exit 0
