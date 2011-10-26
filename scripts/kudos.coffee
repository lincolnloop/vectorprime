# IRC scoring system
#
# kudos - display the score for all nicks
# kudos <nick> - display the score for <nick>
# +x <nick> - increments the value of x for <nick>
# -x <nick> - decrements the value of x for <nick>

module.exports = (robot) ->
  client = robot.brain.client

  robot.respond /\-(\d+) (.*)$/i, (msg) ->
    amount = msg.match[1]
    nick = msg.match[2]

    client.hget "kudos", nick, (err, value) =>
      if not err
        client.hset "kudos", nick, value - amount, (err) =>
          if not err
            msg.send nick + ", no kudos for you."

  robot.respond /\+(\d+) (.*)$/i, (msg) ->
    amount = msg.match[1]
    nick = msg.match[2]

    client.hincrby "kudos", nick, amount, (err) =>
      if not err
        msg.send "kudos " + nick

  robot.respond /kudos (.*)$/i, (msg) ->
    nick = msg.match[1]

    client.hget "kudos", nick, (err, value) =>
      if not err
        msg.send value
  
  robot.respond /kudos$/i, (msg) ->
    kudos = []

    client.hgetall "kudos", (err, values) =>
      for own nick, amount of values
        kudos.push "#{nick} => #{amount}"
    
      msg.send kudos.join "\n"