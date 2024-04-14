extends Sprite2D

@onready var animations = $Button8Animation

func _ready():
	animations.play("idle")

func _process(_delta):
	if Global.haircolorbutton != 7:
		animations.play("idle")

func _on_button_8_pressed():
	animations.play("pressed")
	Global.haircolorbutton = 7
