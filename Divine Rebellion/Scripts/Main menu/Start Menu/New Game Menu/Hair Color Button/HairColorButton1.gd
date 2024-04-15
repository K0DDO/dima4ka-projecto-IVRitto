extends Sprite2D

@onready var animations = $Button1Animation

func _ready():
	animations.play("focused")

func _process(_delta):
	if Global.haircolorbutton != 0:
		animations.play("idle")

func _on_button_1_pressed():
	animations.play("pressed")
	Global.haircolorbutton = 0