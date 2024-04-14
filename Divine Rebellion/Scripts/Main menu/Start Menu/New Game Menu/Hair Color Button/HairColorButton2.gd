extends Sprite2D

@onready var animations = $Button2Animation

func _ready():
	animations.play("idle")

func _process(_delta):
	if Global.haircolorbutton != 1:
		animations.play("idle")

func _on_button_2_pressed():
	animations.play("pressed")
	Global.haircolorbutton = 1
