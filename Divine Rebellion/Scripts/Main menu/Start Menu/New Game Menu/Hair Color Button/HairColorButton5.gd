extends Sprite2D

@onready var animations = $Button5Animation

func _ready():
	animations.play("idle")

func _process(_delta):
	if Global.haircolorbutton != 4:
		animations.play("idle")

func _on_button_5_pressed():
	animations.play("pressed")
	Global.haircolorbutton = 4