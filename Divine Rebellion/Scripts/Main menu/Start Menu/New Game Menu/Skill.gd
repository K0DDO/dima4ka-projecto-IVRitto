extends Sprite2D

func _ready():
	pass

func _process(_delta):
	frame_coords.x = Global.skill

func _on_skill_pressed():
	if Global.skill < 5:
		Global.skill += 1
	else:
		Global.skill = 0
