afdko="$(realpath "$(dirname "$(realpath "${BASH_SOURCE[0]}")")"/afdko)"

if ! command -v python3 >/dev/null; then
        echo "Error: python3 is required"
        exit 1
fi

if ! [ -f "$afdko"/installed ]; then
        echo "Installing AFDKO..."
        rm -rf "$afdko"
        python3 -m venv "$afdko"
        "$afdko"/bin/pip install -U pip setuptools wheel
        "$afdko"/bin/pip install afdko
        touch "$afdko"/installed
fi
