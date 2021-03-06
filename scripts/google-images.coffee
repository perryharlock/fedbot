# Description:
#   A way to interact with the Google Images API.
#
# Commands:
#   hubot image me <query> - The Original. Queries Google Images for <query> and returns a random top result.
#   hubot animate me <query> - The same thing as `image me`, except adds a few parameters to try to return an animated GIF instead.
#   hubot mustache me <url> - Adds a mustache to the specified URL.
#   hubot mustache me <query> - Searches Google Images for the specified query and mustaches it.
#   hubot benny hill me <url> - Adds Benny Hill music to the specified URL.
#   hubot benny hill me <query> - Searches Google Images for the specified query and Benny Hill's it.

module.exports = (robot) ->
  robot.respond /(image|img)( me)? (.*)/i, (msg) ->
    if msg.message.user.name == "Jude"
      return msg.send "Sorry, Jude, I can't let you do that"
    imageMe msg, msg.match[3], (url) ->
      msg.send url

  robot.respond /animate( me)? (.*)/i, (msg) ->
    if msg.message.user.name == "Jude"
      return msg.send "Sorry, Jude, I can't let you do that"
    imageMe msg, msg.match[2], true, (url) ->
      msg.send url

  robot.respond /(?:mo?u)?sta(?:s|c)he?(?: me)? (.*)/i, (msg) ->
    type = Math.floor(Math.random() * 3)
    mustachify = "http://mustachify.me/#{type}?src="
    imagery = msg.match[1]

    if imagery.match /^https?:\/\//i
      msg.send "#{mustachify}#{imagery}"
    else
      imageMe msg, imagery, false, true, (url) ->
        msg.send "#{mustachify}#{url}"

  robot.respond /benny\s?hill me (.*)/i, (msg) ->
    imagery = msg.match[1]
    if imagery.match /^https?:\/\//i
      msg.send getBennyHillUrl(imagery)
    else
      imageMe msg, imagery, true, false, (url) ->
        msg.send getBennyHillUrl(url)

imageMe = (msg, query, animated, faces, cb) ->
  cb = animated if typeof animated == 'function'
  cb = faces if typeof faces == 'function'
  q = v: '1.0', rsz: '8', q: query, safe: 'active'
  q.imgtype = 'animated' if typeof animated is 'boolean' and animated is true
  q.imgtype = 'face' if typeof faces is 'boolean' and faces is true
  msg.http('http://ajax.googleapis.com/ajax/services/search/images')
    .query(q)
    .get() (err, res, body) ->
      images = JSON.parse(body)
      images = images.responseData?.results
      if images?.length > 0
        image  = msg.random images
        cb "#{image.unescapedUrl}#.png"

getBennyHillUrl = (gif) ->
  gif = encodeURIComponent gif
  "http://bennyhill.me/?gif=#{gif}&-="
