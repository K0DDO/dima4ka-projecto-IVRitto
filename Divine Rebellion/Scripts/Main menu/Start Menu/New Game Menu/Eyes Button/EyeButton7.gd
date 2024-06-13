extends Sprite2D

@onready var animations = $Button7Animation

func _ready():
	animations.play("idle")

func _physics_process(_delta):
	if Global.eyebutton != 6:
		animations.play("idle")
	else:
		animations.play("focused")

func _on_button_7_pressed():
	animations.play("pressed")
	Global.eyebutton = 6
