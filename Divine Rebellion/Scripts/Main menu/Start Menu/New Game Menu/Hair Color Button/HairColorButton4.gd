extends Sprite2D

@onready var animations = $Button4Animation

func _ready():
	animations.play("idle")

func _process(_delta):
	if Global.haircolorbutton != 3:
		animations.play("idle")

func _on_button_4_pressed():
	animations.play("pressed")
	Global.haircolorbutton = 3
