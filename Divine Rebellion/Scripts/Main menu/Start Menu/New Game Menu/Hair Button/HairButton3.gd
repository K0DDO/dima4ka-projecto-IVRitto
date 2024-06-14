extends Sprite2D

@onready var animations = $Button3Animation
@onready var child = $"../../Hair3"
var pressed = false

func _ready():
	animations.play("focused")

func _process(_delta):
	if Global.hairbutton != 2:
		animations.play("idle")
	else:
		animations.play("focused")

func _on_button_3_pressed():
	if pressed == false:
		pressed = true
		Global.hairbutton = 2
		position.y += 1
		child.set_position(Vector2(child.position.x, child.position.y + 1))
		await get_tree().create_timer(0.1).timeout
		child.set_position(Vector2(child.position.x, child.position.y - 1))
		position.y -= 1
		await get_tree().create_timer(0.1).timeout
		pressed = false
