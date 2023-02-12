function download {
        if ! (cd downloads && sha256sum --check ../sha256sums.txt) >/dev/null 2>&1; then
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
}
