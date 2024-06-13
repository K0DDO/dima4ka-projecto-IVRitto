extends Sprite2D

@onready var animations = $Animation1
@onready var child = $Boots1
var pressed = false

func _ready():
	animations.play("focused")

func _process(_delta):
	if Global.bootsbutton != 0:
		animations.play("idle")
	else:
		animations.play("focused")

func _on_button_1_pressed():
	if pressed == false:
		pressed = true
		Global.bootsbutton = 0
		animations.play("pressed")
		child.set_position(Vector2(-4, -17))
		await get_tree().create_timer(0.1).timeout
		child.set_position(Vector2(-4, -18))
		await get_tree().create_timer(0.1).timeout
		pressed = false
