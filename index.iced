# hi

code = '++.'

#brainfug input = '', code, (output) ->
#	console.log output

module.exports = global.brainfug = brainfug = (input, code, callback) ->
	_code = code
	_codeIndex = 0
	_input = input
	_inputIndex = 0
	_output = ''
	_pointerIndex = 0
	_pointers = []

	_loopIndexes = []

	_pointers[_pointerIndex] = 0

	_codeIndex = 0

	while _codeIndex < _code.length
		switch _code[_codeIndex]
			when '>'
				_pointerIndex++
				if not _pointers[_pointerIndex]?
					_pointers[_pointerIndex] = 0
			when '<'
				if _pointerIndex != 0
					_pointerIndex--
			when '+' 
				_pointers[_pointerIndex]++
			when '-' 
				_pointers[_pointerIndex]--
			when '['
				_loopIndexes.push _codeIndex
			when ']'
				if _pointers[_pointerIndex] == 0
					_loopIndexes.pop()
				else
					_codeIndex = _loopIndexes[_loopIndexes.length - 1] - 1
					_loopIndexes.pop()
			when ',' 
				_pointers[_pointerIndex] = _input[_inputIndex].charCodeAt(0)
				_inputIndex++
			when '.'
				char = String.fromCharCode(_pointers[_pointerIndex])
				_output += char

		# await setTimeout defer(), 100

		_codeIndex++

	callback _output

#  > increment pointer
#  < decrement pointer
#  + increment value at pointer
#  - decrement value at pointer
#  [ begin loop (continues while value at pointer is non-zero)
#  ] end loop
#  , read one character from input into value at pointer
#  . print value at pointer to output as a character
#  # display debugging info (in debug mode)

r = require('repl').start
	prompt: 'Brainfug> '
	useGlobal: true

r.on 'exit', ->
	console.log '\nTerminating...'
	process.exit()