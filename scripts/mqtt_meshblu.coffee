mqtt = require 'mqtt'

opts =
    host: process.env.MQTT_HOST
    username: process.env.MQTT_USER
    password: process.env.MQTT_PASSWORD

client = mqtt.connect opts
client.subscribe opts.username, {qos: 0}

client.on 'message', (topic, message) ->
    payload = JSON.parse message
    console.log payload.data


module.exports = (robot) ->
#    client.on 'message', (topic, message) ->
#        payload = JSON.parse message
#        robot.send room:'general' , payload.data
