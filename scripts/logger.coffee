# Logs messages to a database

settings = require("../settings.js").settings;
pg = require('pg');
conString = "tcp://" + settings.DB_USER + ":" + settings.DB_PASSWORD + "@localhost/snarl";
client = new pg.Client(conString);

client.connect();

store_msg = (nick, text, timestamp, action=false) ->
    bot_id = process.env.SNARLBOT_ID
    client.query("INSERT INTO logs_log(bot_id, nick, text, timestamp) values($1, $2, $3, $4)", [bot_id, nick, text, timestamp]);

module.exports = (robot) ->
    robot.hear /./, (msg) ->
        user = msg.message.user
        if user.room
            action = false
            text = msg.message.text
            if text.indexOf("ACTION") != -1
                text = text.replace("ACTION ", "")
                action = true
            nick = user.name
            now = new Date()
            store_msg(nick, text, now, action)

    robot.enter (msg) ->
        nick = ""
        text = msg.message.user.name + " has joined the channel"
        now = new Date()
        store_msg(nick, text, now)

    robot.leave (msg) ->
        nick = ""
        text = msg.message.user.name + " has left the channel"
        now = new Date()
        store_msg(nick, text, now)
