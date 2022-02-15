extends Node2D

func _ready():
	add_to_group("shops")
	add_to_group("all_backgrounds")
		
func check_position(char_pos, total_length):
	if abs(position.x - char_pos.x) > total_length/2:
		if position.x > char_pos.x:
			position.x -= total_length
		else:
			position.x += total_length

func get_length():
	return $ShopImage.texture.get_size().x * $ShopImage.scale.x
	
func fade_out():
	$ShopImage.set_self_modulate(lerp($ShopImage.get_self_modulate(), Color(.1,.1,.1,1), 0.2))
	
func fade_in():
	$ShopImage.set_self_modulate(lerp($ShopImage.get_self_modulate(), Color(1, 1, 1, 1), 0.2))
