extends Sprite2D

@onready var animations = $Animation

func _on_next_button_pressed():
	animations.play("pressed")
	if Global.skill == 0:
		Global.friendship = 1
	elif Global.skill == 1:
		Global.combating = 1
	elif Global.skill == 2:
		Global.fishing = 1
	elif Global.skill == 3:
		Global.farming = 1
	elif Global.skill == 4:
		Global.collecting = 1
	elif Global.skill == 5:
		Global.magic = 1
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://Scenes/Game/game.tscn")




