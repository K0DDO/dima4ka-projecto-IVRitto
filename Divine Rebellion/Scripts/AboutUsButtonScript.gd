extends Sprite2D

@onready var animations = $AboutUsButtonAnimation

func _on_about_us_button_pressed():
	$Timer.start()
	animations.play("pressed")

func _on_ready():
	animations.play("idle")

func _on_about_us_button_mouse_entered():
	animations.play("focused")

func _on_about_us_button_mouse_exited():
	animations.play("idle")

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/about_us_menu.tscn")
