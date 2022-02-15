extends Polygon2D


var showing = false
var timer
var timer_reset = .25


# Called when the node enters the scene tree for the first time.
func _ready():
	timer = timer_reset

func light_up():
	showing = true
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if showing:
		visible = true
		timer -= delta
		if timer <= 0:
			visible = false
			showing = false
			timer = timer_reset
