extends Sprite2D

@onready var animations = $Button8Animation
@onready var child = $Hair8
var pressed = false

func _ready():
	animations.play("focused")

func _process(_delta):
	if Global.hairbutton != 8:
		animations.play("idle")

func _on_button_8_pressed():
	if pressed == false:
		pressed = true
		Global.hairbutton = 8
		animations.play("pressed")
		child.set_position(Vector2(2, 4))
		await get_tree().create_timer(0.1).timeout
		child.set_position(Vector2(2, 3))
		await get_tree().create_timer(0.1).timeout
		pressed = false
