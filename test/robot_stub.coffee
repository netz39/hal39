should = require('should')
class Robot
	constructor : () ->
		@responses = []

	respond : (re, fn) ->
		re.should.be.a.RegEx
		fn.should.be.a.Function
		@responses.push([re, fn])

exports.Robot = Robot
	
