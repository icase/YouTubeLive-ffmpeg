fmpg_chk.sh is a script which will control the camera feed to YouTube.

It pulls in the RTSP feed from the IP camera and pushes it out to YouTube 
via ffmpg.

This script is ran every 5 minutes begining at 7am and ending at 2:55pm.
If the feed is not running, the script will attempt to start it.
During this 5 minute interval, it also grabs a still image from the camera
and saves it to the ~/Unifi folder.

There is a script in the home directory which will take all the stills in the
folder and save it to the Public share on the network with a folder name of
the previous monday. I plan on having this script fire off at 3pm on fridays. 
Check crontab for this entry.

At 3pm the script is ran with the stop parameter to stop the camera.


Manual controls are as follows:


start the feed
	./fmpg_chk.sh start

stop the feed
	./fmpg_chk.sh stop


