extends Node2D


# Declare member variables here. Examples:
var last_length: float = 0
var total_length: float = 0
onready var things = get_tree().get_nodes_in_group("backgrounds")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	things.shuffle()
	for thing in things:
		total_length += thing.texture.get_size().x * thing.scale.x
		
	for thing in things:
		thing.position.x = -total_length/2 + last_length
		thing.position.y = 0
		last_length += thing.texture.get_size().x * thing.scale.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for thing in things:
		thing.check_position(total_length)
