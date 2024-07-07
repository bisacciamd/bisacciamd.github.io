#!/bin/bash
# renders in italian
quarto render cv/index.qmd --profile italian
quarto render publications/index.qmd --profile italian

# renders in english
quarto render cv/index.qmd --profile english
quarto render publications/index.qmd --profile english

# gets the current date
current_date=$(date +%Y-%m-%d)

# copies to output/

# Copy CV (IT)
cp docs/it/cv/index.pdf output/Bisaccia_CV_it_${current_date}.pdf

# Copy the publications (IT)
cp docs/it/publications/index.pdf output/Bisaccia_Publications_it_${current_date}.pdf

# Copy the CV (EN)
cp docs/cv/index.pdf output/Bisaccia_CV_en_${current_date}.pdf

# Copy the publications (EN)
cp docs/publications/index.pdf output/Bisaccia_Publications_en_${current_date}.pdf
