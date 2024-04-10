extends Sprite2D

@onready var animations = $Button5Animation

func _ready():
	animations.play("focused")

func _physics_process(_delta):
	if Global.eyebutton != "5":
		animations.play("idle")

func _on_button_5_pressed():
	animations.play("pressed")
	Global.eyebutton = "5"
