#!/usr/bin/env bash
set -euo pipefail

if ! command -v python3 >/dev/null; then
        echo "python3 required"
        exit 1
fi

if ! [ -f afdko/installed ]; then
        echo "Installing AFDKO..."
        rm -rf afdko
        python3 -m venv afdko
        afdko/bin/pip install afdko
        touch afdko/installed
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

echo "Unpacking files..."
cabextract -L -d fonts downloads/*

echo "Cleaning files..."
find fonts -type f \! -name \*.ttf -delete

echo "Creating TTC..."
afdko/bin/otf2otc -o mscorefonts.ttc fonts/*
