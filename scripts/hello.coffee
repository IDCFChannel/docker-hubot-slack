module.exports = (robot) ->
  robot.respond /HELLO$/i, (res) ->
    res.reply "Hi"
