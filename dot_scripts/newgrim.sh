#!/bin/sh

# This is bound to Shift+PrintScreen by default, requires grim. It lets you
# choose the kind of screenshot to take, including copying the image or even
# highlighting an area to copy.

SDIR=$HOME/Pictures/screenshots
VDIR=$HOME/Videos/recording
mkdir -p $VDIR
mkdir -p $SDIR

function is_recording() {
  proc(pidof wf-recorder)
}

function screenshot() {
  echo $1;
  if [ $1 = 'copy' ] 
  then
    grim -g "$(slurp)" -l 0 - | wl-copy;
  elif [ $1 = 'edit' ]
  then
    grim -g "$(slurp)" -l 0 - | swappy -f -;
  elif [ $1 = 'save' ]
  then
    grim -g "$(slurp)" -o filename.png;
  else
    exit -1;
  fi
}

function main() {
  options=(\
    "screenshot selected area (save)"\
    "screenshot selected area (copy)"\
    "screenshot selected area (edit)"\
    "record full screen"\ # M+1 (with mic)
    "record selected area"\ # M+1 (with mic)
    "record sound only"\
    "stop recording"\
  )
  OPTION=$(for o in "${options[@]}"; do
    echo "$o"
  done | bemenu -i -l 7 -p "Prompt >>> ")

}


# case "$(printf "a selected area\\nfull screen\\na selected area (copy)\\nfull screen (copy)\\nrecord full screen\\nrecord selected area\\nstop recording" | bemenu -i -l 7 -p "Screenshot which area?")" in
# "a selected area") grim -g "$(slurp)" $SDIR/grim-selected-"$(date '+%y%m%d-%H%M-%S').png" ;;
# "full screen") grim $SDIR/grim-full-"$(date '+%y%m%d-%H%M-%S').png" ;;
# "a selected area (copy)") grim -g "$(slurp)" - | wl-copy ;;
# "full screen (copy)") grim - | wl-copy ;;
# "record full screen") wf-recorder -f $VDIR/record-full-"$(date '+%y%m%d-%H%M-%S').mp4" ;;
# "record selected area") wf-recorder -g "$(slurp)" -f $VDIR/record-"$(date '+%y%m%d-%H%M-%S').mp4" ;;
# "stop recording") pkill --signal=INT wf-recorder ;;
# esac
