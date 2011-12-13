# Django issue links
#
# django#<issue_number> = returns a link to the Django issue

module.exports = (robot) ->

  robot.respond /django#\d+$/i, (msg) ->
    issue_number = msg.match[1]

    msg.send "https://code.djangoproject.com/ticket/#{issue_number}"