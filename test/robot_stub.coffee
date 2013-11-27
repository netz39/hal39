should = require('should')
class Robot
	constructor : () ->
		@responses = []
		@hears = []

	respond : (re, fn) ->
		re.should.be.a.RegEx
		fn.should.be.a.Function
		@responses.push([re, fn])
	
	hear : (re, fn) ->
		re.should.be.a.RegEx
		fn.should.be.a.Function
		@hears.push([re,fn])

exports.Robot = Robot
	
