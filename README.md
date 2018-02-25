# eyefidocker

This project is a fork of [eyefi-docker](https://github.com/sbma44/eyefi-docker) which again is a fork of [eyefiserver2](https://github.com/dgrant/eyefiserver2).

All the hard work was done by [sbma44](https://github.com/sbma44) and [dgrant](https://github.com/dgrant/)

This projects removes all flickr code and the need for a config file, it uses environment vars instead, so it can be configured using docker-compose

## Configuring

You should adjust the values passed to docker to reflect your card MAC address and upload key. These can be obtained by installing Eye-Fi's proprietary `Keenai` software and completing initial card configuration. On OS X, the relevant values can then be found with the following two commands.

The MAC address:

```sh
echo "select o_mac_address from o_devices;" | sqlite3 "$HOME/Library/Application Support/Keenai/offline.db" | tr -d '-'
```

The upload key:

```sh
echo "select o_upload_key from o_devices;" | sqlite3 "$HOME/Library/Application Support/Keenai/offline.db"
```

NOTE: this build only supports one mac/upload key

## Run the server

Start the server with the appropriate port exposed: `docker run --rm -p 59278:59278 -v $(pwd)/upload:/upload -e MAC=XXXXXXXXXXXX -e UPLOAD_KEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX rockhopperdk:eyefi-docker`.

Your Eye-Fi card, when properly configured to join the same network as your server, will scan its local subnet for a server listening port 59278 and upload images to it. Be sure you're not running Eye-Fi's own software anywhere, or the card might find that server first.

Nikon owners: be aware that recent camera firmwares contain an Eye-Fi specific setting that disables uploads to conserve power. You will need to enable uploads through your camera's on-screen menu system for any of this to work.
