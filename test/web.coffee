Robot = require('./robot_stub.coffee').Robot
should = require('should')

describe 'web.coffee', ->
	describe 'robot', ->
		it 'should call robot.hear', ->
			r = new Robot
			web = require('../scripts/web.coffee')
			web(r)
			r.hears.length.should.be.above(0)

		it 'should answer to url', ->
			r = new Robot
			web = require('../scripts/web.coffee')
			web(r)
			testurls = ["HTTP://Bastinat0r.de", "http://example.com", "https://github.com/netz39/hal39/pull/20", "https://wiki.archlinux.org/index.php/Installation_Guide#Connect_to_the_internet"]
			for url in testurls
				r.hears[0][0].test(url).should.be.true
		
		it 'should answer not answer to something else than an url', ->
			r = new Robot
			web = require('../scripts/web.coffee')
			web(r)
			
			testurls = ["foobar", "irc://blarg.foo", "mail@server.com"]
			for url in testurls
				r.hears[0][0].test(url).should.not.be.true


