# Logs messages to a database

settings = require("../settings.js").settings;
pg = require('pg');
conString = "tcp://" + settings.DB_USER + ":" + settings.DB_PASSWORD + "@localhost/snarl";
console.log(conString)
client = new pg.Client(conString);

client.connect();

store_msg = (bot_id, nick, text, timestamp) ->
        client.query("INSERT INTO logs_log(bot_id, nick, text, timestamp) values($1, $2, $3, $4)", [bot_id, nick, text, timestamp]);

module.exports = (robot) ->
    robot.hear /./, (msg) ->
        nick = msg.message.user.name
        text = msg.message.text
        now = new Date()
        bot_id = 1  # bot_name = msg.robot.name
        store_msg(bot_id, nick, text, now)

    robot.enter (msg) ->
        nick = "<operator>"
        text = msg.message.user.name + " has joined the channel"
        now = new Date()
        bot_id = 1
        store_msg(bot_id, nick, text, now)

    robot.leave (msg) ->
        nick = "<operator>"
        text = msg.message.user.name + " has left the channel"
        now = new Date()
        bot_id = 1
        store_msg(bot_id, nick, text, now)
