# написать shell-процедуру которая:
# вводит символьную строку содержащую текст некоторого сообщения;
# проверяет регистрацию в системе пользователей, чьи имена переданы вторым и последующими параметрами;
# всем пользователям, чьи имена передаются в качестве второго и следующих параметров и работающим в системе в течении заданного первым параметром времени, рассылает введенное сообщение по почте;
# всем остальным пользователям, работающим в данным момент в системе, рассылает прямые сообщения, содержащие введенную символьную строку

#!/bin/bash

# 1 task
echo "input message:"
read msg
echo $msg

echo "input date and users:"
read users 
arr=( $users )

# 2 task
for user in ${arr[@]:1}; do
	if getent passwd | grep -qe $user; then 
		echo $user is registred; 
	else 
		echo $user is not regitred; 
	fi; 
done

# 3 task
last -p ${arr[0]} | awk '{print $1}' | grep -v 'reboot' | grep -v 'wtmp' >time_users
read date_users <time_users

for user in ${arr[@]:1}; do
	case $user in 
		$date_users)
			echo $msg | mail $user
	esac;
done


# 4 task
who | awk '{print $1}' >users
read all_now_work_users <users

echo $all_now_work_users | grep -v $date_users >now_users
read now_users <now_users

for u in $now_users; do
	echo $msg | write $u
done
