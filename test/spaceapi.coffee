Robot = require('./robot_stub.coffee').Robot
should = require('should')

describe 'spaceapi.coffee', ->
	describe 'robot', ->
		it 'should call robot.respond', ->
			r = new Robot
			spaceapi = require('../scripts/spaceapi.coffee')
			spaceapi(r)
			r.responses.length.should.be.above(0)

		it 'should answer to status', ->
			r = new Robot
			spaceapi = require('../scripts/spaceapi.coffee')
			spaceapi(r)
			(i[0].test('status') and i[0].test('STATUS') for i in r.responses).should.contain(true)
