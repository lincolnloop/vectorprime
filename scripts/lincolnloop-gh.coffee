# Lincoln Loop Github issue links
#
# <project>#issue_number = returns a link

module.exports = (robot) ->

  robot.respond /\w+#\d+$/i, (msg) ->
    project = msg.match[1]
    issue_number = msg.match[2]

    msg.send 'https://github.com/lincolnloop/#{project}/issues/#{issue_number}'