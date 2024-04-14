extends Sprite2D

@onready var animations = $Button5Animation
@onready var child = $Hair5
var pressed = false

func _ready():
	animations.play("focused")

func _process(_delta):
	if Global.hairbutton != 5:
		animations.play("idle")

func _on_button_5_pressed():
	if pressed == false:
		pressed = true
		Global.hairbutton = 5
		animations.play("pressed")
		child.set_position(Vector2(0.5, 4))
		await get_tree().create_timer(0.1).timeout
		child.set_position(Vector2(0.5, 3))
		await get_tree().create_timer(0.1).timeout
		pressed = false
