from json import load
from sys import argv
from base64 import b64decode

data = load(open(argv[1]))

for event in data['events']:
    try:
        data = b64decode(event['params']['bytes'])
        if b'client_id' in data and b'client_secret' in data:
            print(data)
    except KeyError:
        pass

    try:
        url = event['params']['url']
        if '?key=' in url or '&key=' in url:
            print(url)
    except KeyError:
        pass

