# Issue links
#
# <project>#<issue_number> = returns a link to a github issue

module.exports = (robot) ->

  robot.respond /(\w+)#(\d+)$/i, (msg) ->
    project = msg.match[1]
    issue_number = msg.match[2]

    if project == "django"
      msg.send "https://code.djangoproject.com/ticket/#{issue_number}"
    else
      msg.send "https://github.com/lincolnloop/#{project}/issues/#{issue_number}"

  robot.respond /(\w+)\/(\w+)#(\d+)$/i, (msg) ->
    owner = msg.match[1]
    project = msg.match[2]
    issue_number = msg.match[3]

    msg.send "https://github.com/#{owner}/#{project}/issues/#{issue_number}"