extends Sprite2D

@onready var animations = $Animation6
@onready var child = $Top6
var pressed = false

func _ready():
	animations.play("idle")

func _process(_delta):
	if Global.topbutton != 5:
		animations.play("idle")
	else:
		animations.play("focused")

func _on_button_6_pressed():
	if pressed == false:
		pressed = true
		Global.topbutton = 5
		position.y += 1
		child.set_position(Vector2(child.position.x, child.position.y + 1))
		await get_tree().create_timer(0.1).timeout
		child.set_position(Vector2(child.position.x, child.position.y - 1))
		position.y -= 1
		await get_tree().create_timer(0.1).timeout
		pressed = false
