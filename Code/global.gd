extends Node

#const CHUNK_SIZE = 1024
var pos = Vector2(0,500)
var passcode = ""
var new_game = true
var building_positions = {}
var code_max_length = 32


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func reset_game():
	pos = Vector2(0,500)
	passcode = ""
	new_game = true
	building_positions = {}
	

func update_passcode(value):
	var number_of_characters = len(value) * 3/4 + 1
	if number_of_characters + len(passcode) > code_max_length:
		number_of_characters = code_max_length - len(passcode) + 1
	passcode += hash_file(value, number_of_characters)
	check_code_size()


func hash_file(value, number):
	var ctx = HashingContext.new()
	ctx.start(HashingContext.HASH_SHA256)
	ctx.update(value.to_ascii())
	# Get the computed hash.
	var res = ctx.finish()
	res = res.hex_encode()
	print(res)
	var code_end = ""
	for i in range(number -1, -1, -1):
		if i:
			code_end += str(res[-i])
	return code_end
	
func check_code_size():
	if len(passcode) >= code_max_length:
		get_tree().call_group("character", "end_game")
