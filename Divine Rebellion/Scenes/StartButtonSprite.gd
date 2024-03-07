extends Sprite2D

var is_pressed : bool = false

func _input(event):
	if is_pressed == false:
		if event is InputEventMouseButton:
			is_pressed = true
			$StartTimerT.start()

func _ready():
	pass

func _process(delta):
	pass

func _on_start_timer_f_timeout():
	if is_pressed == false:
		visible = not visible
		is_pressed = true

func _on_start_timer_t_timeout():
	if is_pressed == true:
		visible = not visible
