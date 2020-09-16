#!/usr/bin/env bash
echo -e "Starting system upgrade, please enter your sudo password below:\n"
/bin/yes | sudo pacman -Syu && echo "Success!"
# throw the user in his default shell
exec $(sudo userdbctl user nova --output "friendly" | grep -i shell | tail -1 |cut -d: -f2)
