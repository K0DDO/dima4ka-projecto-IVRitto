extends Sprite2D

@onready var animations = $NoButtonAnimation

func _on_no_button_pressed():
	$Timer.start()
	animations.play("pressed")

func _on_ready():
	animations.play("idle")

func _on_no_button_mouse_entered():
	animations.play("focused")

func _on_no_button_mouse_exited():
	animations.play("idle")

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _input(_event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
