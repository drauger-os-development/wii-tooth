#!/bin/bash
# -*- coding: utf-8 -*-
#
#  check.sh
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
test=$(/usr/bin/wminput -r -q -c /etc/wii-tooth/wii-tooth-default.conf 2>&1 >/dev/null)
if $(/bin/echo "$test" | /bin/grep -q "No wiimotes found"); then
	/bin/touch /etc/wii-tooth/check.flag
fi