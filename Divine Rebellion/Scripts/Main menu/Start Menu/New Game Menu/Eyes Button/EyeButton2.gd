extends Sprite2D

@onready var animations = $Button2Animation

func _ready():
	animations.play("idle")

func _physics_process(_delta):
	if Global.eyebutton != 2:
		animations.play("idle")

func _on_button_2_pressed():
	animations.play("pressed")
	Global.eyebutton = 2
