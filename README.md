# Gerald Laura-Moore - Personal Website & CV

Personal website and CV hosted on GitHub Pages.

## Structure

- `index.md` - Single source of truth for both website and CV
- `templates/cv.tex` - Pandoc LaTeX template for PDF generation
- `cv/gerald_moore_cv.pdf` - Generated PDF CV
- `_layouts/default.html` - Jekyll layout for website
- `_config.yml` - Jekyll configuration
- `assets/` - Images and icons

## Content Visibility

The `index.md` file uses HTML comment markers to control what appears where:

- **CV-only content** (e.g., phone number, Rust skill): `<!-- cv-only: content -->`
  - Hidden on website (HTML comments are invisible)
  - Included in PDF

- **Web-only content** (e.g., Teaching section): `<!-- web-only -->` ... `<!-- /web-only -->`
  - Visible on website
  - Excluded from PDF

## Building the PDF

### Prerequisites

```bash
brew install just
brew install pandoc
brew install --cask mactex  # or basictex for minimal install
```

### Generate PDF

```bash
just pdf
```

This reads `index.md`, filters out web-only content, extracts cv-only content, and generates `cv/gerald_moore_cv.pdf`.

### Other commands

```bash
just clean       # Remove temporary files
just check-deps  # Verify dependencies are installed
```

## Website

The website is automatically built and deployed by GitHub Pages when changes are pushed to the `main` branch.
