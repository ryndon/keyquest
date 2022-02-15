extends Sprite

var amount = ""
var max_length = 20
onready var screen = $HBox/Amount

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func check_length(num):
	if len(amount) + 1 > max_length:
		return
	else:
		amount += num
		screen.text = amount
		
func get_input():
	if Input.is_action_just_pressed("1"):
		_on_Button1_pressed()
	if Input.is_action_just_pressed("2"):
		_on_Button2_pressed()
	if Input.is_action_just_pressed("3"):
		_on_Button3_pressed()
	if Input.is_action_just_pressed("4"):
		_on_Button4_pressed()
	if Input.is_action_just_pressed("5"):
		_on_Button5_pressed()
	if Input.is_action_just_pressed("6"):
		_on_Button6_pressed()
	if Input.is_action_just_pressed("7"):
		_on_Button7_pressed()
	if Input.is_action_just_pressed("8"):
		_on_Button8_pressed()
	if Input.is_action_just_pressed("9"):
		_on_Button9_pressed()
	if Input.is_action_just_pressed("0"):
		_on_Button0_pressed()
	if Input.is_action_just_pressed("ui_accept"):
		_on_ButtonEnter_pressed()
	if Input.is_action_just_pressed("delete"):
		_on_ButtonBack_pressed()
	
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if modulate.a == 1:
		$ButtonEnter.disabled = false
	get_input()
	

func _on_Button1_pressed():
	check_length("1")
	$Button1/ColorRect.light_up()
func _on_Button2_pressed():
	check_length("2")
	$Button2/ColorRect.light_up()
func _on_Button3_pressed():
	check_length("3")
	$Button3/ColorRect.light_up()
func _on_Button4_pressed():
	check_length("4")
	$Button4/ColorRect.light_up()
func _on_Button5_pressed():
	check_length("5")
	$Button5/ColorRect.light_up()
func _on_Button6_pressed():
	check_length("6")
	$Button6/ColorRect.light_up()
func _on_Button7_pressed():
	check_length("7")
	$Button7/ColorRect.light_up()
func _on_Button8_pressed():
	check_length("8")
	$Button8/ColorRect.light_up()
func _on_Button9_pressed():
	check_length("9")
	$Button9/ColorRect.light_up()
func _on_Button0_pressed():
	check_length("0")
	$Button0/ColorRect.light_up()
func _on_ButtonBack_pressed():
	amount.erase(amount.length()-1, 1)
	$ButtonBack/ColorRect.light_up()
func _on_ButtonEnter_pressed():
	$ButtonEnter/ColorRect.light_up()
	$ButtonEnter.disabled = true
	if amount:
		global.update_passcode(amount)
		amount = ""
	get_parent().get_parent().get_parent()._on_ATMExit_pressed()
