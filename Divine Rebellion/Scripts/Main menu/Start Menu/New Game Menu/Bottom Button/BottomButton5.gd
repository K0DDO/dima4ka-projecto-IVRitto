extends Sprite2D

@onready var animations = $Animation5
@onready var child = $Bottom5
var pressed = false

func _ready():
	animations.play("idle")

func _process(_delta):
	if Global.bottombutton != 5:
		animations.play("idle")

func _on_button_5_pressed():
	if pressed == false:
		pressed = true
		Global.bottombutton = 5
		animations.play("pressed")
		child.set_position(Vector2(-4, -12))
		await get_tree().create_timer(0.1).timeout
		child.set_position(Vector2(-4, -13))
		await get_tree().create_timer(0.1).timeout
		pressed = false
