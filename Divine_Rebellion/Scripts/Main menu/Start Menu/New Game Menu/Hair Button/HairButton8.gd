extends Sprite2D

@onready var animations = $Button8Animation
@onready var child = $"../../Hair8"
var pressed = false

func _ready():
	animations.play("focused")

func _process(_delta):
	if Global.hairbutton != 7:
		animations.play("idle")
	else:
		animations.play("focused")

func _on_button_8_pressed():
	if pressed == false:
		pressed = true
		Global.hairbutton = 7
		position.y += 1
		child.set_position(Vector2(child.position.x, child.position.y + 1))
		await get_tree().create_timer(0.1).timeout
		child.set_position(Vector2(child.position.x, child.position.y - 1))
		position.y -= 1
		await get_tree().create_timer(0.1).timeout
		pressed = false
