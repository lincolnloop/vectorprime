# Django Docs Lookup
#
# django me <term> - Find term in Django's current docs
module.exports = (robot) ->
  robot.respond /django me (.*)/i, (msg) ->
    djangoMe msg, msg.match[1], (url) ->
        msg.send url

djangoMe = (message, term, callback) ->
    site = 'docs.djangoproject.com'
    query = term + ' site:' + site
    message.http('http://www.google.com/search')
    .query(q: query)
    .get() (err, res, body) ->
        callback body.match(/class="r"><a href="\/url\?q=([^"]*)(&amp;sa.*)">/)?[1] || "Sorry, Google couldn't find '#{term}' on #{site}"
