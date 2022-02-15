extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	$Frame/Code.text = global.passcode


func _on_Button_pressed():
	OS.set_clipboard(global.passcode)
	
func _process(delta):
	$Frame.modulate.a += delta


func _on_Play_pressed():
	global.reset_game()
	get_tree().change_scene("res://Code/City/City.tscn")
