#!/bin/bash
curl -O tmp wttr.in/Los%20Alamos > /tmp/weather
cat /tmp/weather | sed \
	-e "s/.\[38;5;.\?.\?.\?m//g"\
	-e "s/.(B//g"\
	-e "s/.\[.\?.\?m//g"\
	-e "8,+40d"
