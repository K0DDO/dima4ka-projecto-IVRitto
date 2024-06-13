extends Sprite2D

@onready var animations = $Button2Animation

func _ready():
	animations.play("idle")

func _physics_process(_delta):
	if Global.eyebutton != 1:
		animations.play("idle")
	else:
		animations.play("focused")

func _on_button_2_pressed():
	animations.play("pressed")
	Global.eyebutton = 1
