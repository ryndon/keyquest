extends KinematicBody2D

export var speed_in = 600
export var speed_out = 400
var speed
var moving = false
var indoors = false
var overlapped = false
var obj
var zoomed = false
var velocity = Vector2()
var gravity = 2400
var limit_left = -1000000000
var limit_right = 1000000000
var fadingHard = false
var fadeIn = false
var endGame = false
onready var blackout = $Blackout

signal blackout(x)

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("character")
	$Blackout.visible = true
	$Camera.limit_left = limit_left
	$Camera.limit_right = limit_right
	fadeIn = true
	

func get_input():
	velocity.x = 0
	velocity.y = 0
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var up = Input.is_action_pressed('ui_up')
	var down = Input.is_action_pressed('ui_down')
	var jump = Input.is_action_just_pressed('ui_select')
	var select = Input.is_action_just_pressed("ui_select")

	if !zoomed:
		if select:
			if overlapped:
				overlapped = false
				get_parent().take_action(obj.name)
		if up:
			velocity.y -= speed
			moving = true
		if down:
			velocity.y += speed
			moving = true
		if right:
			velocity.x += speed
			$Animation.flip_h = false
			moving = true
		if left:
			velocity.x -= speed
			$Animation.flip_h = true
			moving = true
		if jump:
			pass
		

func _physics_process(_delta):
	$Label.text = "("+str(position.x) + ", " + str(position.y)+")" + " ==== " + str(scale)
	if indoors:
		speed = speed_in
		scale = Vector2(.5,.5)
		$Camera.zoom = Vector2(1, 1)
	else:
		speed = speed_out
		scale = Vector2(.18, .18)
		$Camera.zoom = Vector2(.8,.8)
	$Camera.limit_left = limit_left
	$Camera.limit_right = limit_right
	#velocity.y += gravity * delta
	get_input()
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	if moving:
		$Animation.animation = "walk"
	else:
		$Animation.animation = "idle"
	moving = false
	
	check_overlap()
	
func _process(delta):
	$Passcode/Code.text = "  " + global.passcode
	if fadingHard:
		fadeIn = false
		blackout.visible = true
		blackout.modulate.a += delta*2
		if blackout.modulate.a >= 1:
			if endGame:
				get_tree().change_scene("res://Code/Character/FinalCode.tscn")
			else:
				fadingHard = false
				emit_signal("blackout", obj.name)
	if fadeIn:
		blackout.modulate.a -= delta*2
		if blackout.modulate.a <= 0:
			fadeIn = false
			blackout.visible = false
		
		
		
func check_overlap():
	var overlap = $Area2D.get_overlapping_areas()
	if overlap:
		overlapped = true
		obj = overlap[0]
	else:
		overlapped = false
	
func fade_out_hard():
	fadingHard = true
	
func end_game():
	fade_out_hard()
	endGame = true
