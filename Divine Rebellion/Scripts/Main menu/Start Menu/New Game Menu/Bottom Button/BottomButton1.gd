extends Sprite2D

@onready var animations = $Animation1
@onready var child = $Bottom1
var pressed = false

func _ready():
	animations.play("focused")

func _process(_delta):
	if Global.bottombutton != 0:
		animations.play("idle")
	else:
		animations.play("focused")

func _on_button_1_pressed():
	if pressed == false:
		pressed = true
		Global.bottombutton = 0
		position.y += 1
		child.set_position(Vector2(child.position.x, child.position.y + 1))
		await get_tree().create_timer(0.1).timeout
		child.set_position(Vector2(child.position.x, child.position.y - 1))
		position.y -= 1
		await get_tree().create_timer(0.1).timeout
		pressed = false
