extends Sprite2D

@onready var animations = $Button10Animation
@onready var child = $Hair10
var pressed = false

func _ready():
	animations.play("focused")

func _process(_delta):
	if Global.hairbutton != 10:
		animations.play("idle")

func _on_button_10_pressed():
	if pressed == false:
		pressed = true
		Global.hairbutton = 10
		animations.play("pressed")
		child.set_position(Vector2(1, 5))
		await get_tree().create_timer(0.1).timeout
		child.set_position(Vector2(1, 4))
		await get_tree().create_timer(0.1).timeout
		pressed = false
