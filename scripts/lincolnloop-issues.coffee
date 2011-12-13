# Github issue links
#
# <project>#<issue_number> = returns a link to a github issue

module.exports = (robot) ->

  robot.respond /(\w+)\/(\w+)#(\d+)$/i, (msg) ->
    owner = msg.match[1]
    project = msg.match[2]
    issue_number = msg.match[3]

    msg.send "https://github.com/#{owner}/#{project}/issues/#{issue_number}"