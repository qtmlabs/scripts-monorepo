#!/usr/bin/env bash
set -euo pipefail

source ../common/afdko.bash

if ! command -v mkfontscale >/dev/null; then
        echo "mkfontscale required"
        exit 1
fi

rm -rf fonts

if ! (cd downloads && sha256sum --check ../sha256sums.txt); then
        mkdir -p downloads
        cd downloads

        echo "Downloading files..."
        wget -ci ../urls.txt

        echo "Validating checksums..."
        sha256sum --check ../sha256sums.txt

        cd ..
else
        echo "Already downloaded"
fi

echo "Creating TTC..."
"$afdko"/bin/otf2otc -o dtfonts.ttc downloads/*
