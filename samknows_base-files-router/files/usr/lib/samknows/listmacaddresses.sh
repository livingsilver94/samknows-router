#!/bin/sh

. /etc/unit_specific

INTERFACE_NR=0
eval INTERFACE='$'UNIT_MAC${INTERFACE_NR}

while [ -n "$INTERFACE" ]; do
	MAC=$(cat /sys/class/net/${INTERFACE}/address | sed 's/://g' | tr [a-f] [A-F])
	if [ $INTERFACE_NR -eq 0 ]; then
		OUTPUT="mac=${MAC}"
	else
		OUTPUT="${OUTPUT}&mac${INTERFACE_NR}=${MAC}"
	fi

	INTERFACE_NR=$((INTERFACE_NR+1))
	eval INTERFACE='$'UNIT_MAC${INTERFACE_NR}
done

printf "$OUTPUT"
