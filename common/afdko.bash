afdko="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"/afdko

source "$(dirname "$(realpath "${BASH_SOURCE[0]}")")"/python.bash

if ! [ -f "$afdko"/installed ]; then
        echo "Installing AFDKO..."
        rm -rf "$afdko"
        "$python" -m venv "$afdko"
        "$afdko"/bin/pip install -U pip setuptools wheel
        "$afdko"/bin/pip install afdko
        touch "$afdko"/installed
fi
