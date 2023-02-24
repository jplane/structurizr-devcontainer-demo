#! /bin/bash

# if you need to refresh the Azure icons (they're released every few months)

# download icons https://learn.microsoft.com/en-us/azure/architecture/icons/

# unzip here to 'icons' folder

# sudo apt-get install inkscape

# create new PNGs from SVGs
find "$PWD" | grep -i '.*[.]svg' | xargs -n1 -I % inkscape --export-dpi=192 --export-png=%.png %

# sudo apt install rename

# rename .svg.png to .png
find . -iname "*.svg.*" -exec rename 's/svg.png/png/' '{}' \;

# manually rename icon subfolders to remove spaces (easier to ref inside DSL)
