#!/usr/bin/env bash
set -euo pipefail

source ../common/python.bash
source ../common/download.bash

if ! command -v mkfontscale >/dev/null; then
        echo "mkfontscale required"
        exit 1
fi

download

rm -rf fonts

echo "Creating TTC..."
"$python" ../common/otf2otc.py -o dtfonts.ttc downloads/*
