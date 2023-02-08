#!/usr/bin/env bash
set -euo pipefail

if ! command -v otf2otc >/dev/null; then
        echo "otf2otc required"
        exit 1
fi

rm -rf fonts
mkdir -p downloads
cd downloads

echo "Downloading files..."
wget -ci ../urls.txt

echo "Validating checksums..."
sha256sum --check ../sha256sums.txt

cd ..

echo "Unpacking files..."
cabextract -L -d fonts downloads/*

echo "Cleaning files..."
find fonts -type f \! -name \*.ttf -delete

echo "Creating TTC..."
otf2otc -o mscorefonts.ttc fonts/*
