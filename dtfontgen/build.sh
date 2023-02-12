#!/usr/bin/env bash
set -euo pipefail

source ../common/python.bash
source ../common/download.bash

if ! command -v mkfontscale >/dev/null; then
        echo "mkfontscale required"
        exit 1
fi

download
