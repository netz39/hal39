Robot = require('./robot_stub.coffee').Robot
should = require('should')

describe 'ical.coffee', ->
	describe 'robot', ->
		it 'should call robot.respond', ->
			r = new Robot
			ical = require('../scripts/ical.coffee')
			ical(r)
			r.responses.length.should.be.above(0)

		it 'should answer to next', ->
			r = new Robot
			ical = require('../scripts/ical.coffee')
			ical(r)
			(i[0].test('next') and i[0].test('NEXT') for i in r.responses).should.contain(true)

		it 'should answer to upcoming', ->
			r = new Robot
			ical = require('../scripts/ical.coffee')
			ical(r)
			(i[0].test('upcoming') and i[0].test('UPCOMING') for i in r.responses).should.contain(true)
