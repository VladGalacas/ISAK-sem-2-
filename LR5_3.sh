#!/bin/bash

params=$@
arr_params=( $params )

while true; do
	echo "input message (enter 'quit' to stop):"
	read msg
	if [[ $msg != 'quit' ]]; then
		for user in ${arr_params[@]:2}; do
			if who | grep -qe $user; then
				echo $msg | write $user
			fi;
		done
	else
		break
	fi;
done
