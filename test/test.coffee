# example test from http://visionmedia.github.io/mocha to test the testing
assert = require('assert')

describe 'Array', ->
	describe '#indexOf()', ->
		it 'should return -1 when the value is not present', ->
			assert.equal -1, [1,2,3].indexOf(0)
			assert.equal -1, [1,2,3].indexOf(5)
