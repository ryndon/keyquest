extends "res://Code/ATM/ATM.gd"


var operator = ""
var stored = 0.0
var code = ""

func _init():
	max_length = 9
	
# Called when the node enters the scene tree for the first time.
func _ready():
	$HBox/Amount.text = '0'

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func get_input():
	if Input.is_action_just_pressed("multiply"):
		_on_ButtonMulti_pressed()
	if Input.is_action_just_pressed("add"):
		_on_ButtonAdd_pressed()
	if Input.is_action_just_pressed("subtract"):
		_on_ButtonSub_pressed()
	if Input.is_action_just_pressed("divide"):
		_on_ButtonDiv_pressed()
	.get_input()
	
func check_length(num):
	if $HBox/Amount.text == '0':
		$HBox/Amount.text = ''
	.check_length(num)
	
func calculate():
	if operator:
		match operator:
			'+':
				stored += float($HBox/Amount.text)
			'-':
				stored -= float($HBox/Amount.text)
			'*':
				stored *= float($HBox/Amount.text)
			'/':
				stored /= float($HBox/Amount.text)
		operator = ''
		if len(str(stored)) > max_length:
			stored = round(stored)
			var size = len(str(stored))
			var value = stored
			while value >= 10.0:
				value = value/10.0
			var text = str(value).substr(0,max_length-3) + "e" + str(size - 1)
			$HBox/Amount.text = text
		else:
			$HBox/Amount.text = str(stored)
			
			
func capture_stored():
	stored = float(amount)
	code += str(stored/4)
	amount = ''
	$HBox/Amount.text = operator
	
func reset_calc():
	operator = ""
	stored = 0.0
	amount = ''
	$HBox/Amount.set_text('0')
	
func _on_ButtonBack_pressed():
	reset_calc()
	$ButtonBack/ColorRect.light_up()
	
func _on_ButtonEnter_pressed():
	calculate()
	$ButtonEnter/ColorRect.light_up()
	
func _on_ButtonAdd_pressed():
	operator = '+'
	capture_stored()
	$ButtonAdd/ColorRect.light_up()
func _on_ButtonSub_pressed():
	operator = '-'
	capture_stored()
	$ButtonSub/ColorRect.light_up()
func _on_ButtonMulti_pressed():
	operator = '*'
	capture_stored()
	$ButtonMulti/ColorRect.light_up()
func _on_ButtonDiv_pressed():
	operator = '/'
	capture_stored()
	$ButtonDiv/ColorRect.light_up()
	
func _on_ButtonPower_pressed():
	global.update_passcode(code)
	reset_calc()
	get_parent().reset_fade()
	
	
# set_focus() was necessary for the Phone and rather than specify when to call
# this function from the parent, it was easier to just give all of the UI items
# the same function.
func set_focus():
	pass
func reset_focus():
	pass
