# Hubot with Slack and MQTT on Docker

## デバイスのID

ACTION-1からACTION-3にメッセージを送信できるようにします。

```sh
$ docker-compose run --rm iotutil whiten -- -f action-1 -t action-3

> iotutil@0.0.1 start /app
> node app.js "whiten" "-f" "action-1" "-t" "action-3"

action-1 can send message to action-3
```