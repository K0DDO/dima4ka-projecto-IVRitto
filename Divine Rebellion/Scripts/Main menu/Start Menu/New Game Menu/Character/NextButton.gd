extends Sprite2D

@onready var animations = $Animation

func _on_next_button_pressed():
	animations.play("pressed")
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://Scenes/Game/game.tscn")
