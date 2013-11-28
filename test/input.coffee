util = require('util')
timers = require('timers')
should = require('should')

describe 'hubot', ->
	it 'should accept input', (done) ->
		this.timeout(3000)
		test_input = () ->
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

			send_input = () ->
				try
					hubot.stdin.write('foobar\n', 'utf-8')
					hubot.stdin.on 'error', (e) ->
						util.puts e
				catch error
					util.puts error
			timers.setTimeout( send_input , 500 )

			end = () ->
				hubot.kill
				output.should.not.be.empty
				util.puts output
				done()
			timers.setTimeout( end , 1900)
		setTimeout( test_input , 1000 )

