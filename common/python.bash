if command -v pypy3 >/dev/null; then
        python=pypy3
elif command -v python3 >/dev/null; then
        python=python3
else
        echo "Error: python3 is required"
        exit 1
fi
