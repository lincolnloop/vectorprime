# Last seen user

Brain = require "../src/vectorprime/brain"
moment = require "moment"

module.exports = (robot) ->
    client = new Brain
    robot.hear /./, (msg) ->
        nick = msg.message.user.name
        text = msg.message.text
        console.log JSON.stringify msg.message
        now = new Date()
        client.hset "seen", nick, now.getTime() + ':' + text, (err) =>
            return

    robot.respond /seen ([\w.-]+)$/, (msg) ->
        name = msg.match[1]
        client.hget "seen", name, (err, value) =>
            if value and not err
                colonIndex = value.indexOf ':'
                timestamp = value.substr 0, colonIndex
                lastMessage = value.substr colonIndex + 1
                since = moment(timestamp).fromNow()
                msg.send('Yeah, I saw ' + name + ' ' + since + '.\nHe said, "' + lastMessage + '".')
            else
                msg.send("Sorry, " + msg.message.user.name + ", I haven't seen " + name + '.')
