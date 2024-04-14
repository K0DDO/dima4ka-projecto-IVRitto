extends Sprite2D

@onready var animations = $Animation2
@onready var child = $Top2
var pressed = false

func _ready():
	animations.play("idle")

func _process(_delta):
	if Global.topbutton != 2:
		animations.play("idle")

func _on_button_2_pressed():
	if pressed == false:
		pressed = true
		Global.topbutton = 2
		animations.play("pressed")
		child.set_position(Vector2(-4, -7.5))
		await get_tree().create_timer(0.1).timeout
		child.set_position(Vector2(-4, -8.5))
		await get_tree().create_timer(0.1).timeout
		pressed = false
