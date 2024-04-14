extends Sprite2D

@onready var animations = $Button6Animation
@onready var child = $Hair6
var pressed = false

func _ready():
	animations.play("focused")

func _process(_delta):
	if Global.hairbutton != 6:
		animations.play("idle")

func _on_button_6_pressed():
	if pressed == false:
		pressed = true
		Global.hairbutton = 6
		animations.play("pressed")
		child.set_position(Vector2(0.5, 5))
		await get_tree().create_timer(0.1).timeout
		child.set_position(Vector2(0.5, 4))
		await get_tree().create_timer(0.1).timeout
		pressed = false
