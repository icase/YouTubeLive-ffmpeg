#!/bin/bash

# Function to create time stamp
datestamp () {

	local timestamp=`date --rfc-3339=seconds`
	echo $timestamp
}

#function to find the PID of ffmpeg
ffmpeg_pid () {

	local PID=$(pgrep ffmpeg)
	echo $PID
}

#Function to start the stream to youtube
start_stream () {

	nohup ffmpeg -rtsp_transport tcp -i rtsp://192.168.0.100:554/s0  -f flv -c:v libx264 -preset ultrafast -maxrate 3000k -bufsize 6000k -x264-params keyint=120 -c:a copy rtmp://a.rtmp.youtube.com/live2/YOUR_KEY &>/dev/null &
}



#if the script is called to start, look for a running process. If its running, log the attempt and take a snapshot.
if [[ $(ffmpeg_pid) && "$1" = "start" ]]; then
	
	echo $(datestamp) "- Stream is live using PID " $(ffmpeg_pid)
	wget -O /home/user/unifi/"$(datestamp)".jpeg 192.168.0.100/snap.jpeg

#if the script is called to start and there is no runnung process, start the stream.
elif [[ -z $(ffmpeg_pid) && "$1" = "start" ]]; then

	echo $(datestamp)  "- Stream is not running, attempting to start"
	start_stream

#if the script is called to stop, kill the stream
elif [[ $(ffmpeg_pid) && "$1" = "stop" ]]; then

	echo $(datestamp)  "- Stopping stream"
	kill $(ffmpeg_pid)

#if the script is called to stop and there is no running process, just log the attempt. Not sure why this would even happen :)
elif [[ -z $(ffmpeg_pid) && "$1" = "stop" ]]; then
	echo $(datestamp) "- Recieved the stop command but the stream was not running. No Action Taken. "

fi
