extends Sprite


var text = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BibleExit_pressed():
	$BibleText.text = ""
	get_parent().reset_fade()


func _on_SaveButton_pressed():
	text = $BibleText.text
	if text:
		global.update_passcode(text)
	_on_BibleExit_pressed()
