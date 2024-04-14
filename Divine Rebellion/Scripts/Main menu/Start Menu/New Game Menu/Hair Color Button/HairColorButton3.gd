extends Sprite2D

@onready var animations = $Button3Animation

func _ready():
	animations.play("idle")

func _process(_delta):
	if Global.haircolorbutton != 2:
		animations.play("idle")

func _on_button_3_pressed():
	animations.play("pressed")
	Global.haircolorbutton = 2
