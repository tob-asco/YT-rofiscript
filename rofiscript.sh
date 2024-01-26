#!/bin/bash

case "$( echo 'find thesis pdfs,bash history,PATH commands,cd home' | rofi -sep ',' -dmenu -i )" in
    "find thesis pdfs")
        # find pdf's in my thesis folder and open with okular
        find ~/UHH/thesis -name "*.pdf" | rofi -dmenu | xargs -r okular
        ;;

    "bash history")
        # search through history and paste into copy register
        tac ~/.bash_history | grep -vE '^#' | awk '!seen[$0]++' | rofi -dmenu -dpi 80 | xsel --input
        ;;

    "PATH commands")
        # print PATH commands together with their whatis; put into copy register
        for com in $(compgen -c | awk '!seen[$0]++'); do
            whatis $com 2>/dev/null || echo $com
        done | rofi -dmenu | awk '{print $1}' | xsel --input
        ;;

    "cd home")
        # list home directories and cd into them
        urxvt -e bash -c "cd $(find ~ -type d | rofi -dmenu) && pwd && bash"
        ;;
esac
