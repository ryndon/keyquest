extends Node2D


onready var c = $Character
onready var background = $Sprite
onready var selectedNode = $Bible
var fadingOut = false

# Called when the node enters the scene tree for the first time.
func _ready():
	c.connect("blackout", self, "change_scene")
	c.get_node("Animation").flip_h = false
	c.position = Vector2(-1475, 450)
	c.indoors = true
	c.limit_left = -1700
	c.limit_right = 1700

func _process(delta):
	
	if fadingOut:
		background.set_modulate(lerp(background.get_modulate(), Color(.1,.1,.1,1), 0.2))
		selectedNode.modulate.a += delta
		if selectedNode.modulate.a >1:
			selectedNode.modulate.a = 1
			$Character.visible = false
	else:
		background.set_modulate(lerp(background.get_modulate(), Color(1, 1, 1, 1), 0.2))
		selectedNode.modulate.a -= delta
		if selectedNode.modulate.a < 0:
			selectedNode.modulate.a = 0
			selectedNode.visible = false
			
			
func take_action(name):
	match name:
		"DoorArea":
			c.fade_out_hard()
		"BibleArea":
			var bible = $Bible
			fade_out(bible)
		"PianoArea":
			var piano = $Piano
			fade_out(piano)
			
func change_scene(name):
	match name:
		"DoorArea":
			get_tree().change_scene("res://Code/City/City.tscn")
			
func fade_out(node):
	selectedNode = node
	fadingOut = true
	selectedNode.visible = true
	c.zoomed = true
	
func reset_fade():
	fadingOut = false
	c.zoomed = false
	c.visible = true
	

func _on_DoorArea_area_entered(area):
	$DoorArea/Polygon.visible = true

func _on_DoorArea_area_exited(area):
	$DoorArea/Polygon.visible = false

func _on_BibleArea_area_entered(area):
	$BibleArea/ColorRect.visible = true

func _on_BibleArea_area_exited(area):
	$BibleArea/ColorRect.visible = false

func _on_PianoArea_area_entered(area):
	$PianoArea/Polygon.visible = true

func _on_PianoArea_area_exited(area):
	$PianoArea/Polygon.visible = false
