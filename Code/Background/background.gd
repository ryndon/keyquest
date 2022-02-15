extends Node2D

func _ready():
	add_to_group("backgrounds")
	add_to_group("all_backgrounds")
		
func check_position(char_pos, total_length):
	if abs(position.x - char_pos.x) > total_length/2:
		if position.x > char_pos.x:
			position.x -= total_length - 5
		else:
			position.x += total_length - 5

func get_length():
	return 1024 #$street.texture.get_size().x * $street.scale.x
	
func fade_out():
	$Parallax/Layer/background.set_modulate(lerp($Parallax/Layer/background.get_modulate(), Color(.1,.1,.1,1), 0.2))
	$Parallax/Layer/street.set_modulate(lerp($Parallax/Layer/street.get_modulate(), Color(.1,.1,.1,1), 0.2))
	
func fade_in():
	$Parallax/Layer/background.set_modulate(lerp($Parallax/Layer/background.get_modulate(), Color(1,1,1,1), 0.2))
	$Parallax/Layer/street.set_modulate(lerp($Parallax/Layer/street.get_modulate(), Color(1,1,1,1), 0.2))
