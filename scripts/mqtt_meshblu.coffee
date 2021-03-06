# -*- coding: utf-8 -*-

mqtt = require 'mqtt'

opts =
    host: process.env.MQTT_HOST
    username: process.env.ACTION_1_UUID
    password: process.env.ACTION_1_TOKEN
    protocolId: 'MQIsdp'
    protocolVersion: 3

client = mqtt.connect opts
client.subscribe process.env.ACTION_1_UUID

sensor_data = ''

client.on 'message', (topic, message) ->
    payload = JSON.parse message
    sensor_data = payload.data.payload

commands =
    '気温': 'temperature'
    '湿度': 'humidity'
    '気圧': 'pressure'

units =
    '気温': '℃'
    '湿度': '%'
    '気圧': 'hPa'

module.exports = (robot) ->
    robot.hear  /(気温|湿度|気圧)を(おしえて|教えて)$/i, (res) ->
        sensor = res.match[1]
        answer = if sensor_data
            retval = sensor_data[commands[sensor]] + ' ' + units[sensor]
            sensor + 'は ' + retval + ' です。'
        else
            'データが取れません。:imp:'
        res.send answer

    robot.hear /ライトを(つけて|付けて|けして|消して)$/i, (res) ->
        on_off = switch res.match[1]
            when 'つけて', '付けて' then 'led-on'
            when 'けして', '消して' then 'led-off'
            else 'led-on'
        answer = if on_off == 'led-on' then 'ピカッ。' else 'カチッ。'

        message =
            devices: process.env.ACTION_3_UUID
            payload: on_off
        client.publish 'message', JSON.stringify(message)

        res.send answer + ':flashlight:'
