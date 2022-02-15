extends Node2D


onready var c = $Character
onready var background1 = $Down
onready var background2 = $Up

var selectedNode
var fadingOut = false

# Called when the node enters the scene tree for the first time.
func _ready():
	c.connect("blackout", self, "change_scene")
	c.indoors = true
	set_down()
	c.position = Vector2(95, 450)
	
func _process(delta):
	$Passcode/Code.text = global.passcode
	
	if fadingOut:
		background1.set_modulate(lerp(background1.get_modulate(), Color(.1,.1,.1,1), 0.2))
		background2.set_modulate(lerp(background2.get_modulate(), Color(.1,.1,.1,1), 0.2))
		selectedNode.modulate.a += delta
		if selectedNode.modulate.a >1:
			selectedNode.modulate.a = 1
			c.visible = false
			selectedNode.set_focus()

func set_down():
	c.get_node("Animation").flip_h = false
	c.get_node("Camera").limit_bottom = 600
	c.position.y = 450
#	c.position = Vector2(-930, 450)
	c.limit_left = -1400
	c.limit_right = 1400
	
	
func set_up():
	c.get_node("Animation").flip_h = false
	c.get_node("Camera").limit_bottom = -40
	c.position.y = -190
#	c.position = Vector2(-930, -190)
	c.limit_left = -1400
	c.limit_right = 1800

func take_action(name):
	match name:
		"DoorArea":
			c.fade_out_hard()
		"AreaUp":
			c.fade_out_hard()
		"AreaDown":
			c.fade_out_hard()
		"PhoneArea":
			var phone = $Phone
			fade_out(phone)
		"CalculatorArea":
			var calc = $Calc
			fade_out(calc)
			
func change_scene(name):
	match name:
		"DoorArea":
			get_tree().change_scene("res://Code/City/City.tscn")
		"AreaUp":
			set_down()
			c.fadeIn = true
		"AreaDown":
			print("check 1")
			set_up()
			c.fadeIn = true
	
func fade_out(node):
	selectedNode = node
	fadingOut = true
	selectedNode.visible = true
	c.zoomed = true
	
func reset_fade():
	fadingOut = false
	background1.modulate = Color(1,1,1,1)
	background2.modulate = Color(1,1,1,1)
	selectedNode.visible = false
	selectedNode.modulate.a = 0
	selectedNode.reset_focus()
	c.zoomed = false
	c.visible = true

func _on_DoorArea_area_entered(area):
	$DoorArea/ColorRect.visible = true

func _on_DoorArea_area_exited(area):
	$DoorArea/ColorRect.visible = false
	
func _on_AreaDown_area_entered(area):
	$Down/AreaDown/ColorRect.visible = true

func _on_AreaUp_area_entered(area):
	$Up/AreaUp/ColorRect.visible = true

func _on_AreaDown_area_exited(area):
	$Down/AreaDown/ColorRect.visible = false

func _on_AreaUp_area_exited(area):
	$Up/AreaUp/ColorRect.visible = false

func _on_PhoneArea_area_entered(area):
	$PhoneArea/Polygon.visible = true

func _on_PhoneArea_area_exited(area):
	$PhoneArea/Polygon.visible = false

func _on_CalculatorArea_area_entered(area):
	$CalculatorArea/ColorRect.visible = true

func _on_CalculatorArea_area_exited(area):
	$CalculatorArea/ColorRect.visible = false
