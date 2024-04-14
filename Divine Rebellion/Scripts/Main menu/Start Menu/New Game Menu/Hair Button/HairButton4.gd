extends Sprite2D

@onready var animations = $Button4Animation
@onready var child = $Hair4
var pressed = false

func _ready():
	animations.play("focused")

func _process(_delta):
	if Global.hairbutton != 4:
		animations.play("idle")
		
func _on_button_4_pressed():
	if pressed == false:
		pressed = true
		Global.hairbutton = 4
		animations.play("pressed")
		child.set_position(Vector2(0.5, 4))
		await get_tree().create_timer(0.1).timeout
		child.set_position(Vector2(0.5, 3))
		await get_tree().create_timer(0.1).timeout
		pressed = false
