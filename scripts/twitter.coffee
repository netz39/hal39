# Description
#   Filters out Twitter stream and displays tweets
#
# Dependencies:
#   "twit": "1.1.6"
#
# Configuration:
#   HUBOT_IRC_ROOMS
#   HUBOT_TWITTER_CONSUMER_KEY
#   HUBOT_TWITTER_CONSUMER_SECRET
#   HUBOT_TWITTER_ACCESS_TOKEN
#   HUBOT_TWITTER_ACCESS_TOKEN_SECRET
#   HUBOT_TWITTER_ALLOW_RETWEETS
#   HUBOT_TWITTER_FILTER
#   HUBOT_TWITTER_ROOMS
#
# Commands:
#   None
#
# Author:
#   apfohl

Twit = require "twit"
util = require "util"
config =
  consumer_key: process.env.HUBOT_TWITTER_CONSUMER_KEY
  consumer_secret: process.env.HUBOT_TWITTER_CONSUMER_SECRET
  access_token: process.env.HUBOT_TWITTER_ACCESS_TOKEN
  access_token_secret: process.env.HUBOT_TWITTER_ACCESS_TOKEN_SECRET

allRooms = process.env.HUBOT_TWITTER_ROOMS.split(',')

module.exports = (robot) ->
  twit = undefined
  stream = undefined

  setTimeout () ->
    twit = new Twit config
    stream = twit.stream("statuses/filter", track: process.env.HUBOT_TWITTER_FILTER)

    stream.on "tweet", (tweet) ->
      if not tweet.retweeted_status? or process.env.HUBOT_TWITTER_ALLOW_RETWEETS
        for room in allRooms
          robot.messageRoom room, "Twitter - #{tweet.user.screen_name}: #{tweet.text}"
  
    stream.on "disconnect", (disconnectMessage) ->
      for room in allRooms
        robot.messageRoom room, "I've got disconnected from Twitter stream. Apparently the reason is: #{JSON.stringify(disconnectMessage)}"
  
    stream.on "reconnect", (request, response, connectInterval) ->
      for room in allRooms
        robot.messageRoom room, "I'll reconnect to Twitter stream in #{connectInterval}ms"

  , 20 * 1000
