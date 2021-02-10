#!/bin/bash
cd /workdir
git fetch --prune
dvc repro

echo "Writing report for $(git rev-parse HEAD)"

echo "# Style transfer" >> report.md
git show origin/master:final_owl.png > master_owl.png
convert +append final_owl.png master_owl.png out.png
convert out.png -resize 75%  out_shrink.png
echo "### Workspace vs. Master" >> report.md
cml-publish out_shrink.png --md --title 'compare' >> report.md

echo "## Training metrics" >> report.md
dvc params diff master --show-md >> report.md

cml-send-comment report.md