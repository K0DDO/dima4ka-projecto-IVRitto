extends Sprite2D

@onready var animations = $Button4Animation

func _ready():
	animations.play("idle")

func _physics_process(_delta):
	if Global.eyebutton != 3:
		animations.play("idle")
	else:
		animations.play("focused")

func _on_button_4_pressed():
	animations.play("pressed")
	Global.eyebutton = 3
