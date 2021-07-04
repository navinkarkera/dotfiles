#!/bin/sh

# convert  /home/navin/Videos/extract_table_website/background_resized.jpg \
#     -gravity SouthWest -pointsize 100 \
#     -undercolor yellow -fill 'srgb(90,103,216,255)' \
#     -font /home/navin/Downloads/fonts/Karantina-Bold.ttf \
#     -annotate +35+255 'EXTRACT TABLE FROM WEBSITE' \
#     -font /home/navin/Downloads/fonts/BungeeInline-Regular.ttf \
#     -undercolor 'srgb(90,103,216,255)' -fill yellow \
#     -gravity SouthWest -pointsize 50 \
#     -annotate +35+190 'in 3 lines of code' \
#     -size 300x100 -background DarkGreen -fill white -undercolor transparent \
#     -gravity center -pointsize 40 caption:"Pandas" \
#     -gravity NorthEast -geometry +35+100 -composite \
#     /home/navin/Videos/extract_table_website/out.jpg
convert background.png -resize 1280x720 background_resized.jpg
convert ~/Downloads/icons/gitlab-icon-rgb.png -resize 150x150 gitlab.png

convert background_resized.jpg \
    -size 1000x280 -background 'srgb(90,50,216,255)' -fill yellow -undercolor transparent \
    -font /home/navin/Downloads/fonts/Karantina-Bold.ttf \
    -gravity center -pointsize 120 \
    caption:"BUILD YOUR WEBSITE WITH ZOLA" \
    -gravity SouthWest -geometry +5+270 -composite \
    -size 1000x100 -background yellow -fill black -undercolor transparent \
    -font /home/navin/Downloads/fonts/BungeeInline-Regular.ttf \
    -gravity center -pointsize 50 \
    caption:"Deploying to gitlab pages" \
    -gravity SouthWest -geometry +5+170 -composite \
    -size 200x50 -background 'srgb(240,4,127,255)' -fill black -undercolor transparent \
    -font /home/navin/Downloads/fonts/BungeeInline-Regular.ttf \
    -gravity center -pointsize 40 \
    caption:"Part-7" \
    -gravity NorthWest -geometry +5+120 -composite \
    \( -size 300x100 -rotate 90 -background transparent -fill white -undercolor transparent \
     jamstack_resized.png \
    -gravity NorthEast -geometry +5+25 \) -composite \
    \( -size 150x150 -background transparent -fill white -undercolor transparent \
     gitlab.png \
    -gravity SouthEast -geometry +253+150 \) -composite \
    out.jpg

    # -gravity center -pointsize 40 caption:"Pandas" \

# echo -n "venv" | sed 's/./&@/g; s/@$//' | tr '@' '\012' |\
#     convert out.jpg \
#     -size 50x130 -background yellow -fill black -undercolor transparent \
#     -font /home/navin/Downloads/fonts/Roboto-Bold.ttf -pointsize 20 \
#     -gravity center label:@- -gravity East -geometry +35-40 -composite \
#     out.jpg
