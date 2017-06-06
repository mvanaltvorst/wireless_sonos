#!/bin/bash

SPEAKERIP="192.168.178.49"
LOCALHOSTIP="$(hostname -I)"

cd "$(dirname "$0")" # We need to run scripts from the current directory, so let's head there first

user="$(who)"

function cleanup {
    echo "Cleaning up default.pa..."
    cp ./authenticdefault.pa /etc/pulse/default.pa
    echo "Restarting pulseaudio..."
    su - $user -c "pulseaudio -k; pulseaudio -D"
}
trap cleanup EXIT

echo "Modifying default.pa..."
cp ./modifieddefault.pa /etc/pulse/default.pa

echo "Restarting pulseaudio..."
su - $user -c "pulseaudio -k; pulseaudio -D"

echo "Launching cvlc daemon..."
su - $user -c 'cvlc --live-caching 800 "rtp://@127.0.0.1:46998" --sout "#transcode{vcodec=none,acodec=mp3,ab=256,channels=2,samplerate=44100}:http{dst=:8554/audio.mp3}" ' & # Transcode audio for http://localhost:8554/audio.mp3

echo "Telling Sonos speaker to use audio stream"
python3 ./speaker.py $LOCALHOSTIP $SPEAKERIP

wait
