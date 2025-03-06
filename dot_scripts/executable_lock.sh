#! /bin/bash

grim /tmp/lockscreen.png
convert -scale 10% -scale 50% /tmp/lockscreen.png /tmp/lockscreen.png
# convert -scale 10% -scale 1000% /tmp/lockscreen.png /tmp/lockscreen.png
# convert -swirl 720 /tmp/lockscreen.png /tmp/lockscreen.png
swaylock -i /tmp/lockscreen.png
