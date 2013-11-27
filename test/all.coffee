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
			output = output + data
		hubot.on 'close', (exitcode) ->
			exitcode.should.be(0)


		test_input = () ->
			hubot.stdin.write("foobar\n", 'utf-8')

		timers.setTimeout( test_input, 2500 )


		end = () ->
			hubot.kill
			output.should.not.be.empty
			util.puts output
			done()
		timers.setTimeout( end , 9000)

		

