extends Control


var number = ""
var focused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Button1.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = number
	
	if focused:
		if Input.is_action_just_pressed("ui_select"):
			show_input()
			
func set_focus():
	if focused:
		return
	else:
		$Button1.grab_focus()
		focused = true

func reset_focus():
	focused = false
	
func show_input():
	var focus = get_focus_owner()
	match focus.name:
		"Button1":
			number += "1"
		"Button2":
			number += "2"
		"Button3":
			number += "3"
		"Button4":
			number += "4"
		"Button5":
			number += "5"
		"Button6":
			number += "6"
		"Button7":
			number += "7"
		"Button8":
			number += "8"
		"Button9":
			number += "9"
		"Button10":
			number += "0"
		"Button11":
			number += "*"
		"Button12":
			number += "#"
		"PhoneExit":
			_on_Exit_pressed()


func _on_Exit_pressed():
	if number:
		global.update_passcode(number)
		number = ""
	get_parent().reset_fade()
