extends Sprite2D

@onready var animations = $Animation

func _ready():
	animations.play("idle")

func _on_rarrow_button_pressed():
	animations.play("pressed")
	if Global.num > 0:
		Global.num -= 1
	elif Global.num == 0:
		Global.num = 3
