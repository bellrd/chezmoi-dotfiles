#!/bin/sh

# This is bound to Shift+PrintScreen by default, requires maim. It lets you
# choose the kind of screenshot to take, including copying the image or even
# highlighting an area to copy. scrotcucks on suicidewatch right now.

mkdir -p $HOME/Pictures/screenshots
SDIR=$HOME/Pictures/screenshots

case "$(printf "a selected area\\ncurrent window\\nfull screen\\na selected area (copy)\\ncurrent window (copy)\\nfull screen (copy)" | dmenu -l 6 -i -p "Screenshot which area?")" in
	"a selected area") maim -s $SDIR/pic-selected-"$(date '+%y%m%d-%H%M-%S').png" ;;
	"current window") maim -i "$(xdotool getactivewindow)" $SDIR/pic-window-"$(date '+%y%m%d-%H%M-%S').png" ;;
	"full screen") maim $SDIR/pic-full-"$(date '+%y%m%d-%H%M-%S').png" ;;
	"a selected area (copy)") maim -s | xclip -selection clipboard -t image/png ;;
	"current window (copy)") maim -i "$(xdotool getactivewindow)" | xclip -selection clipboard -t image/png ;;
	"full screen (copy)") maim | xclip -selection clipboard -t image/png ;;
esac
