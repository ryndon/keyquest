extends Node2D

var note = preload("res://Code/Church/Note.tscn")
var note_pos = Vector2()
var midC_y = -475
var start_x
var x_reset = -275
var margin_x = 60
var margin_y = 10
var notes = []
var code = ""

func _ready():
	start_x = x_reset
	
func _process(delta):
	if modulate.a == 1:
		enable_keys()
	
func move_pos():
	start_x += margin_x
	
func make_note(num):
	if notes.size() < 10:
		var pos_y = midC_y - num * margin_y
		var n = note.instance()
		n.position = Vector2(start_x, pos_y)
		notes.append(n)
		add_child(n)
		move_pos()
	if notes.size() == 10:
		exit_piano()
		

func exit_piano():
	for i in range(notes.size() -1, -1, -1):
		notes.pop_back().queue_free()
	start_x = x_reset
	if code:
		global.update_passcode(code)
		code = ""
	disable_keys()
	get_parent().reset_fade()
		
func disable_keys():
	for i in $Piano.get_children():
		i.disabled = true
		
func enable_keys():
	for i in $Piano.get_children():
		i.disabled = false
	
func _on_MidC_pressed():
	make_note(0)
	code += 'C'

func _on_D_pressed():
	make_note(1)
	code += 'D'

func _on_E_pressed():
	make_note(2)
	code += 'E'

func _on_F_pressed():
	make_note(3)
	code += 'F'

func _on_G_pressed():
	make_note(4)
	code += 'G'

func _on_A_pressed():
	make_note(5)
	code += 'A'

func _on_B_pressed():
	make_note(6)
	code += 'B'

func _on_HighC_pressed():
	make_note(7)
	code += 'CC'
