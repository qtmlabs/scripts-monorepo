#!/usr/bin/env bash
set -euo pipefail

source ../common/afdko.bash
source ../common/download.bash

rm -rf fonts

download

echo "Unpacking files..."
cabextract -L -d fonts downloads/*

echo "Cleaning files..."
find fonts -type f \! -name \*.ttf -delete

echo "Creating TTC..."
"$afdko"/bin/otf2otc -o mscorefonts.ttc fonts/*
