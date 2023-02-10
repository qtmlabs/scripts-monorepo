#!/usr/bin/env bash
set -euo pipefail

source ../common/afdko.bash
source ../common/download.bash

if ! command -v mkfontscale >/dev/null; then
        echo "mkfontscale required"
        exit 1
fi

download

rm -rf fonts

echo "Creating TTC..."
"$afdko"/bin/otf2otc -o dtfonts.ttc downloads/*
