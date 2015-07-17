# -*- coding: utf-8 -*-

mqtt = require 'mqtt'

opts =
    host: process.env.MQTT_HOST
    username: process.env.MQTT_USER
    password: process.env.MQTT_PASSWORD

client = mqtt.connect opts
client.subscribe opts.username, {qos: 0}

sensor_data = ''

client.on 'message', (topic, message) ->
    payload = JSON.parse message
    sensor_data = payload.data
    console.log sensor_data

commands =
    '気温': 'temperature'
    '湿度': 'humidity'
    '気圧': 'pressure'

units =
    '気温': '℃'
    '湿度': '%'
    '気圧': 'hPa'

module.exports = (robot) ->
    robot.respond  /今の(気温|湿度|気圧)は[\?？]$/i, (msg) ->
        sensor = msg.match[1]
        retval = sensor_data[commands[sensor]] + ' ' + units[sensor]
        answer = sensor + 'は' + retval + ' です。'
        msg.send answer
