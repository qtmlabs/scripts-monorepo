#!/usr/bin/env bash
set -euo pipefail

source ../common/afdko.bash

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

echo "Unpacking files..."
cabextract -L -d fonts downloads/*

echo "Cleaning files..."
find fonts -type f \! -name \*.ttf -delete

echo "Creating TTC..."
"$afdko"/bin/otf2otc -o mscorefonts.ttc fonts/*
