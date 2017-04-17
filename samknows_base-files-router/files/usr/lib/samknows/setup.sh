#!/bin/sh

RETRY_TIME=300

. /etc/unit_specific

sksetupled() {
	cat $UNIT_LED/max_brightness > $UNIT_LED/brightness
}

skledon() {
	printf default-on > $UNIT_LED/trigger
}
                        
skledactivity() {
	printf timer > $UNIT_LED/trigger
	echo 100 > $UNIT_LED/delay_off
	echo 100 > $UNIT_LED/delay_on
}
                                                
skleddelay() {
	echo timer > $UNIT_LED/trigger
	echo 250 > $UNIT_LED/delay_off
	echo 250 > $UNIT_LED/delay_on
}

sksetupled

# Set QSS LED flashing
skledactivity

# Sleep randomly
sleep $(($RANDOM % 60))
 
# Setup time
REMOTENOW=$(curl -m 20 -s 'http://ntp.samknows.com/?tz=UTC&fmt=new')
if [ $? -eq 0 ]; then
   TZ=UTC date -s "$REMOTENOW"
   logger -s -p 6 -t 'pm' "setup.sh (Info) Time synced successfully, time is now $(date)"
fi

# Check time
NOW=$(date +%s)
if [ $NOW -lt 1206316800 ]; then
   logger -s -p 6 -t 'pm' "setup.sh (Error) Time is clearly wrong ($(date))"
fi

ecode=1
while [ ${ecode} -ne 0 ]; do
	mkdir -p /tmp/samknows
	dcsclient -r -d dcs.samknows.com
	ecode=$?
	if [ ${ecode} -eq 0 ]; then
		DCSSERVER=$(cat /tmp/samknows/dcs);
		# Run the DCS client
		dcsclient -a && dcsclient -p
		ecode=$?
		if [ ${ecode} -eq 0 ]; then
			logger -s -p 6 -t 'pm' "setup.sh (Info) Unit Activation Successfull with DCS ${DCSSERVER}"
		else
			logger -s -p 6 -t 'pm' "setup.sh (Info) Unit Activation Fail with DCS ${DCSSERVER}"
		fi
	else
		logger -s -p 6 -t 'pm' "setup.sh (Info) Unit doesn't know the DCSSERVER to activate with"
	fi

	# If anything went wrong, wait and retry
	if [ ${ecode} -ne 0 ]; then
		skleddelay
		sleep ${RETRY_TIME}
		skledactivity
	fi
done

skledon

exit 0
