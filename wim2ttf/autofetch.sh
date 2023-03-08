#!/usr/bin/env bash
set -euo pipefail

url="https://software-static.download.prss.microsoft.com/dbazure/988969d5-f34g-4e03-ac9d-1f9786c66751/22621.525.220925-0207.ni_release_svc_refresh_CLIENTENTERPRISEEVAL_OEMRET_x64FRE_en-us.iso"

umount -l download/iso || true
umount -l download/mnt || true

mkdir -p download/iso
mkdir -p download/mnt
mkdir -p download/cache

../common/httpdirfs --cache --cache-location "$(realpath download/cache)" --dl-seg-size 1 --max-seg-count $((1024 * 1024)) --single-file-mode "$url" download/iso
../common/lklfuse -o type=udf,ro download/iso/* download/mnt

echo "Extracting fonts from Windows 11 ISO over network..."
echo "(This will take up to ~400MiB of data usage)"

./wim2ttf download/mnt/sources/install.wim 1

umount -l download/mnt
umount -l download/iso
