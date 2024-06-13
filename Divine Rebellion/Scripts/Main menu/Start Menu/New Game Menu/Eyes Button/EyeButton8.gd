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
	animations.play("pressed")
	Global.eyebutton = 7
