#!/bin/bash
# -*- coding: utf-8 -*-
#
#  wiimote-driver.sh
#  
#  Copyright 2019 Thomas Castleman <contact@draugeros.ml>
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#
x="0"
echo "$$" > /etc/wii-tooth/pid.flag
while true; do
	STATUS=$(rfkill list | grep 'Bluetooth' -A 2 | grep 'Soft blocked: ')
	if $(echo "$STAUS" | grep -q 'yes'); then
		sleep 30s
		continue
	fi
	check="$(/bin/ls /etc/wii-tooth)"
	/bin/echo "$check" | /bin/grep -q "check.flag"
	test="$?"
	if [ "$test" == "1" ] && [ "$x" == "1" ]; then
		/bin/sleep 5s
		continue
	elif [ "$test" == "0" ] && [ "$x" == "1" ]; then
		/usr/bin/notify-send "Wiimote Disconnected"
		/bin/rm /etc/wii-tooth/check.flag
		/bin/sleep 0.5s
	elif [ "$test" == "0" ] && [ "$x" == "0" ]; then
		/bin/rm /etc/wii-tooth/check.flag
		/bin/sleep 0.1s
	fi
	/etc/wii-tooth/check.sh &
	/bin/sleep 8s
	check="$(/bin/ls /etc/wii-tooth)"
	/bin/echo "$check" | /bin/grep -q "check.flag"
	if [ "$?" == "1" ]; then
		/usr/bin/notify-send "Wiimote Connected"
		x="1"
		/bin/sleep 10s
	elif [ "$x" == "1" ]; then
		x="0"
		/bin/sleep 0.5s
	fi
done
