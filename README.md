# wireless_sonos
A script that automatically changes your sound settings to use a Sonos speaker as your computer speakers.

This script is Linux only and will probably stay Linux only.

# Installation
Make sure you have Python 3 installed with `soco`. You can install soco with the following command:
```bash
pip install soco
```

Then we clone the repo with the following command:
```bash
git clone https://github.com/Maplicant/wireless_sonos.git
```

Then we setup our firewall to allow an outgoing tcp stream on porn 8554
```bash
sudo iptables -I INPUT -p tcp --dport 8554 -j ACCEPT
```

Then change line 3 of the `wirelesssound.sh` to the IP of the sonos speaker

`authenticdefault.pa` was the original `/etc/pulse/default.pa` that was supplied with my Ubuntu distribution.
`modifieddefault.pa` is the same as `authenticdefault.pa` with the following 3 extra lines appended to the end:
```
load-module module-null-sink sink_name=rtp channels=2 rate=44100 
load-module module-rtp-send source=rtp.monitor destination=127.0.0.1 port=46998 loop=1
set-default-sink rtp
```
You should try manually creating these files if my files don't work for you.

To run the script, use the following command:
```bash
sudo ./wirelesssound.sh
```
(the script needs root privileges to modify `/etc/pulse/default.pa`)
