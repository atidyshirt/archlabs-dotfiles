#!/bin/bash

confirm() {
    echo -e "Yes\nNo" | rofi -dmenu -theme rosebox -i -format d -selected-row 1 -p "${1:-Confirm: }"
}

suspend="Suspend"
reboot="reboot"
shutdown="shutdown"


content="$suspend\n$reboot\n$shutdown"

selection=$(echo -e $content | rofi -dmenu -theme rosebox -i -markup-rows -p "Action: ")
case $selection in
    $reload)
        pkill -USR1 -x sxhkd ;;
    $restartpan)
        pkill panel ; pkill trayer ; panel & ;;
    $quitpan)
        pkill panel ; pkill trayer ; bspc config top_padding 0 ;;
    $quit)
        [[ $(confirm) = 1 ]] && (pkill panel ; pkill trayer ; (for win in $(bspc query -N); do bspc node $win -c ; done;) ; bspc quit) ;;
    $suspend)
        [[ $(confirm) = 1 ]] && (systemctl suspend -i) ;;
    $reboot)
        [[ $(confirm) = 1 ]] && (systemctl reboot -i) ;;
    $shutdown)
        [[ $(confirm) = 1 ]] && (systemctl poweroff -i) ;;
esac
