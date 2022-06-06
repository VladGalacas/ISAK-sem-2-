# Написать shell-процедуру, которая: 
# 1) всем пользователям, работающим в системе, имена которых задаются третьим и последующими параметрами, рассылает сообщения, текст которого вводится с клавиатуры при исполнении процедуры; 
# 2) повторяет сообщения с периодичностью, задаваемой первым параметром; 
# 3) прекращает выдачу сообщений при вводе слова quit и прекращает свою работу

#!/bin/bash

params=$@
arr_params=( $params )

while true; do
	sleep "$1"s
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
