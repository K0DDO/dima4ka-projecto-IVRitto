extends Sprite2D

var is_pressed : bool = false
@onready var animations = $StartButtonAnimation

func _input(event):
	if is_pressed == false:
		if event is InputEventMouseButton:
			is_pressed = true
			visible = not visible

func _on_start_timer_f_timeout():
	if is_pressed == false:
		visible = not visible
		is_pressed = true

func _on_start_button_pressed():
	animations.play("pressed")

func _on_ready():
	animations.play("idle")

func _on_start_button_mouse_entered():
	animations.play("focused")

func _on_start_button_mouse_exited():
	animations.play("idle")
