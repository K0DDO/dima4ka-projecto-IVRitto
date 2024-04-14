extends Sprite2D

@onready var animations = $Button6Animation

func _ready():
	animations.play("idle")

func _process(_delta):
	if Global.haircolorbutton != 5:
		animations.play("idle")

func _on_button_6_pressed():
	animations.play("pressed")
	Global.haircolorbutton = 5
