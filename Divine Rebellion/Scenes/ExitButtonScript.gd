extends Sprite2D

var is_pressed : bool = false

func _input(event):
	if is_pressed == false:
		if event is InputEventMouseButton:
			is_pressed = true
			visible = not visible

func _on_exit_timer_f_timeout():
	if is_pressed == false:
		visible = not visible
		is_pressed = true
