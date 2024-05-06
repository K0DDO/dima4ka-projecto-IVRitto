extends Sprite2D

@onready var animations = $Animation4
@onready var child = $Bottom4
var pressed = false

func _ready():
	animations.play("idle")

func _process(_delta):
	if Global.bottombutton != 4:
		animations.play("idle")

func _on_button_4_pressed():
	if pressed == false:
		pressed = true
		Global.bottombutton = 4
		animations.play("pressed")
		child.set_position(Vector2(-4, -12))
		await get_tree().create_timer(0.1).timeout
		child.set_position(Vector2(-4, -13))
		await get_tree().create_timer(0.1).timeout
		pressed = false
