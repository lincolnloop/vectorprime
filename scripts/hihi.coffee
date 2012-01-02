# French laughs
#
# Any number of hihi's will return the image

module.exports = (robot) ->

  robot.hear /(hi){2,}/i, (msg) ->
    msg.send "http://i.mahner.org/hihi-1-20111213-181425.jpg"
