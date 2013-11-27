util = require('util')
timers = require('timers')

describe 'hubot', ->
	it 'should not crash for 9 seconds', (done) ->
		this.timeout(10000)
		output = ""
		child_process = require('child_process')
		hubot = child_process.spawn('node_modules/.bin/hubot')
		hubot.stderr.on 'data', (data) ->
			data.should.be.null
			util.puts "stderr: " + data
		hubot.stdout.on 'data', (data) ->
			util.puts data
			output = output + data
		hubot.on 'close', (exitcode) ->
			exitcode.should.be(0)

		#timers.setTimeout( hubot.stdin.write, 2500, "foobar\n", 'utf-8')


		end = () ->
			hubot.kill
			output.should.not.be.empty
			done()
		timers.setTimeout( end , 9000)

		

