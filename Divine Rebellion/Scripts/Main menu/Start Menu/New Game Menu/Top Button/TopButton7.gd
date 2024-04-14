extends Sprite2D

@onready var animations = $Animation7
@onready var child = $Top7
var pressed = false

func _ready():
	animations.play("idle")

func _process(_delta):
	if Global.topbutton != 7:
		animations.play("idle")

func _on_button_7_pressed():
	if pressed == false:
		pressed = true
		Global.topbutton = 7
		animations.play("pressed")
		child.set_position(Vector2(-2.5, -5.5))
		await get_tree().create_timer(0.1).timeout
		child.set_position(Vector2(-2.5, -6.5))
		await get_tree().create_timer(0.1).timeout
		pressed = false
