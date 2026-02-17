# Directories and files
src := "index.md"
template := "templates/cv.tex"
output := "cv/gerald_moore_cv.pdf"
tmp_dir := ".tmp"

# Default PDF recipe
default: 
    just --list

# Build PDF
pdf:
    @echo "Generating PDF..."
    @mkdir -p {{tmp_dir}}
    @# Filter out web-only sections and extract cv-only content
    @perl -0777 -pe ' \
        s/<!--\s*web-only\s*-->.*?<!--\s*\/web-only\s*-->//gs; \
        s/<!--\s*cv-only:\s*(.*?)\s*-->/$$1/g; \
    ' {{src}} > {{tmp_dir}}/cv-filtered.md
    @# Run Pandoc to generate PDF
    pandoc {{tmp_dir}}/cv-filtered.md \
        --template={{template}} \
        --pdf-engine=xelatex \
        -V geometry:margin=5mm \
        -o {{output}}
    @echo "Generated {{output}}"

# Clean build artifacts
clean:
    rm -rf {{tmp_dir}}
    rm -f *.aux *.log *.out *.fls *.fdb_latexmk *.synctex.gz

# Check dependencies are installed
check-deps:
    #!/usr/bin/env bash
    command -v pandoc >/dev/null 2>&1 || { echo "Error: pandoc is required. Install with: brew install pandoc"; exit 1; }
    command -v xelatex >/dev/null 2>&1 || { echo "Error: xelatex is required. Install with: brew install --cask mactex"; exit 1; }
    echo "All dependencies found."
