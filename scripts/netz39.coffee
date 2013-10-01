# Description:
#   Get the open/close status of the Netz39 hackerspace
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot status - Displays the Netz39 status
#
# Author:
#   apfohl

module.exports = (robot) ->
  robot.respond /status/i, (msg) ->
    status msg

status = (msg) ->
  msg.http("http://spaceapi.n39.eu/json")
    .get() (err, res, body) ->
      if err
        msg.send "Encountered an error :( #{err}"
        return
      data = JSON.parse(body)
      if data.open
        msg.send('Netz39 is open' + ' since ' + (new Date(data.lastchange * 1000)))
      else
        msg.send('Netz39 is closed' + ' since ' + (new Date(data.lastchange * 1000)))
