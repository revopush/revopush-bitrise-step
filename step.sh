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

if which revopush > /dev/null; then
  echo "Uninstall previous version of revopush CLI."
  npm uninstall revopush
fi

echo "Installing Revopush CLI..."

if [ ! -z "$version" ] ; then
  npm install -g @revopush/code-push-cli@$version --silent > /dev/null 2>&1
else
  npm install -g @revopush/code-push-cli --silent > /dev/null 2>&1
fi

echo "Logging in to Revopush..."
revopush logout > /dev/null 2>&1 || true
revopush login --accessKey $access_key
echo "Execute command..."
revopush $command
echo "Logging out from Revopush..."
revopush logout > /dev/null 2>&1 || true

exit 0
