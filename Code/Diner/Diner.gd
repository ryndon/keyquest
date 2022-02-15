extends Node2D

onready var c = $Character

# Called when the node enters the scene tree for the first time.
func _ready():
	c.connect("blackout", self, "change_scene")
	c.get_node("Animation").flip_h = true
	c.scale = Vector2(.7, .7)
	c.indoors = true
	c.position = Vector2(1215, 430)
	c.limit_left = -1450
	c.limit_right = 1450

func take_action(name):
	match name:
		"DoorArea":
			c.fade_out_hard()
			
			
func change_scene(name):
	match name:
		"DoorArea":
			get_tree().change_scene("res://Code/City/City.tscn")
	

func _on_DoorArea_area_entered(area):
	$DoorArea/Polygon.visible = true

func _on_DoorArea_area_exited(area):
	$DoorArea/Polygon.visible = false
