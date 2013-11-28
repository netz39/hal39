util = require('util')
timers = require('timers')
should = require('should')

describe 'hubot', ->
	this.timeout(9000)
	output = ""
	child_process = require('child_process')
	hubot = child_process.spawn('node_modules/.bin/hubot')
	hubot.stderr.on 'data', (data) ->
		data.should.be.null
		util.puts "stderr: " + data

	hubot.stdout.on 'data', (data) ->
		output = output + data

	it 'should accept input', (done) ->
		this.timeout(2000)
		send_input = () ->
			hubot.stdin.write('foobar\n', 'utf-8')
			hubot.stdin.end()
			done()
		timers.setTimeout( send_input , 1000 )
	
	it 'should not crash for 3 seconds', (done) ->
		this.timeout(4000)
		hubot.on 'close', (exitcode) ->
			exitcode.should.equal(0)

		end = () ->
			hubot.kill
			output.should.not.be.empty
			output.should.not.include("ERROR Error: listen EADDRINUSE")
			util.puts "\nstdout: " + output
			done()
		timers.setTimeout( end , 3000 )

