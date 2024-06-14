extends Sprite2D

@onready var animations = $Button8Animation

func _ready():
	animations.play("idle")

func _physics_process(_delta):
	if Global.eyebutton != 7:
		animations.play("idle")
	else:
		animations.play("focused")

func _on_button_8_pressed():
	Global.eyebutton = 7
	position.y += 1
	await get_tree().create_timer(0.1).timeout
	position.y -= 1
