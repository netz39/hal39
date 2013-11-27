util = require('util')
timers = require('timers')

describe 'hubot', ->
	it 'should not crash for 3 seconds', (done) ->
		this.timeout(2900)
		output = ""
		child_process = require('child_process')
		hubot = child_process.spawn('node_modules/.bin/hubot')
		hubot.stderr.on 'data', (data) ->
			data.should.be.null
			util.puts "stderr: " + data
		hubot.stdout.on 'data', (data) ->
			output = output + data
		hubot.on 'close', (exitcode) ->
			exitcode.should.be(0)

		end = () ->
			hubot.kill
			output.should.not.be.empty
			util.puts output
			done()
		timers.setTimeout( end , 2900)

		

