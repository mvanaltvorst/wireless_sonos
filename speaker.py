from soco import SoCo
import sys

my_zone = SoCo(sys.argv[2])
my_zone.play_uri('http://{}:8554/audio.mp3'.format(sys.argv[1]))
