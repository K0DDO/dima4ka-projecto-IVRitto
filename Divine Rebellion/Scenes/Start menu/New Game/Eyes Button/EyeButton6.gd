extends Sprite2D

@onready var animations = $Button6Animation

func _ready():
	animations.play("focused")

func _physics_process(_delta):
	if Global.eyebutton != "6":
		animations.play("idle")

func _on_button_6_pressed():
	animations.play("pressed")
	Global.eyebutton = "6"
