extends Node2D

onready var c = $Character

# Called when the node enters the scene tree for the first time.
func _ready():
	c.connect("blackout", self, "change_scene")
	c.get_node("Animation").flip_h = false
	c.scale = Vector2(.7, .7)
	c.indoors = true
	c.position = Vector2(5, 440)
	c.limit_left = -1200
	c.limit_right = 1200
	
func take_action(name):
	match name:
		"DoorArea":
			c.fade_out_hard()

func change_scene(name):
	match name:
		"DoorArea":
			get_tree().change_scene("res://Code/City/City.tscn")
	

func _on_DoorArea_area_entered(area):
	$DoorArea/ColorRect.visible = true

func _on_DoorArea_area_exited(area):
	$DoorArea/ColorRect.visible = false
