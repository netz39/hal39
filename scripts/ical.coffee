# Description:
#   Get upcoming events and next event from ical
#
#
# Dependencies:
#   "ical": "0.2.0"
#
# Configuration:
#   HUBOT_ICAL_URL
#
# Commands:
#   hubot upcoming - display list of upcoming events
#   hubot next - disply next event in detail
#
# Author:
#   bastinat0r
#

ical = require 'ical'
util = require 'util'

getEvents = (cb) ->
	ical.fromURL process.env.HUBOT_ICAL_URL, {}, (err, data) ->
		events = []
		(events.push(event) for key, event of data when event.start? and (new Date(event.start)).getTime() < (new Date()).getTime() + 1000 * 3600 * 24 * 30)
		events = events.sort (a, b) ->
			return (new Date(a.start)).getTime() - (new Date(b.start)).getTime()
		cb(events)


module.exports = (robot) ->
	robot.respond /upcoming\s*(.*)?$/i, (msg) ->
		msg.send "Upcoming events:\n"
		getEvents (events) ->
			(msg.send "#{event.start} — #{event.summary} \n" for key, event of events when event.start? and event.summary?)

	robot.respond /next\s*(.*)?$/i, (msg) ->
		emit = "Next Event: \n"
		getEvents (events) ->
			msg.send("#{events[0].start} — #{events[0].summary}\n #{events[0].description}")
