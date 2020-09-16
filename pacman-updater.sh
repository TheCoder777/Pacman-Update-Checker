#!/usr/bin/env bash

# DISPLAY=:0
# DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
PATTERN=">"

sleep 1

while true; do
    updates=$(checkupdates)
    if [[ -z $updates ]]; then # no updates
        dunstify --urgency=NORMAL -a "UPDATE SCRIPT" -i check-filled "System ist up to date!"

    else # updates
        count=$(grep -o "$PATTERN" <<< "$updates" | wc -l )
        if [[ $count == "1" ]]; then # single update
            answer=$(dunstify --urgency=NORMAL -a "UPDATE SCRIPT" -i draw-arrow-down -t 10000 -A Y,"Update now" -A N,Later "$count new Update aviable!" "$(checkupdates)")
        else # multiple updates
            answer=$(dunstify --urgency=NORMAL -a "UPDATE SCRIPT" -i draw-arrow-down -t 10000 -A Y,"Update now" -A N,Later "$count new Updates aviable!" "$(checkupdates)")
        fi

        case $answer in
            Y) /usr/bin/termite --hold -e './command.sh'
            ;;
    	    N)
    		;;
    	    *)
    		;;
        esac
    fi
    sleep 18000  # 5 hours
done
