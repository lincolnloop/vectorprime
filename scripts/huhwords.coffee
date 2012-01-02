# Stores various data and associates it with a word to recall it
#
# huhwords - display the current list of huhwords available
# x = <data> - sets the value of x to <data>
# x? - display the data associated with x
# forget x - remove x from huhwords

Brain = require "../src/vectorprime/brain"

module.exports = (robot) ->
  client = new Brain

  robot.respond /forget (.*)$/i, (msg) ->
    term = msg.match[1]
    value = msg.match[2]

    client.hdel "huh", term, (err) =>
      if not err
        msg.send term + " forgotten"

  robot.respond /(.*) = (.*)$/i, (msg) ->
    term = msg.match[1]
    value = msg.match[2]

    client.hset "huh", term, value, (err) =>
      if not err
        msg.send term + " stored"

  robot.hear /(\S+)\?/i, (msg) ->
    term = msg.match[1]
    client.hget "huh", term, (err, value) =>
      if not err
        msg.send value

  robot.respond /huhwords$/i, (msg) ->
    client.hkeys "huh", (err, words) =>
      if not err
        msg.send words.join "\n"
