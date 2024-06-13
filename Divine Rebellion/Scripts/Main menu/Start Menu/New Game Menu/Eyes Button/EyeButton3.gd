extends Sprite2D

@onready var animations = $Button3Animation

func _ready():
	animations.play("idle")

func _physics_process(_delta):
	if Global.eyebutton != 2:
		animations.play("idle")
	else:
		animations.play("focused")

func _on_button_3_pressed():
	animations.play("pressed")
	Global.eyebutton = 2
