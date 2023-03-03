#!/usr/bin/env bash
set -euo pipefail

source ../common/python.bash
source ../common/download.bash

rm -rf fonts

download

echo "Unpacking files..."
cabextract -L -d fonts downloads/*

echo "Cleaning files..."
find fonts -type f \! -name \*.ttf -delete

mkfontscale fonts
mkfontdir fonts
