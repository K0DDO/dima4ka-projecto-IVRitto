extends Sprite2D

@onready var animations = $Animation3
@onready var child = $Bottom3
var pressed = false

func _ready():
	animations.play("idle")

func _process(_delta):
	if Global.bottombutton != 3:
		animations.play("idle")

func _on_button_3_pressed():
	if pressed == false:
		pressed = true
		Global.bottombutton = 3
		animations.play("pressed")
		child.set_position(Vector2(-4, -13))
		await get_tree().create_timer(0.1).timeout
		child.set_position(Vector2(-4, -14))
		await get_tree().create_timer(0.1).timeout
		pressed = false
