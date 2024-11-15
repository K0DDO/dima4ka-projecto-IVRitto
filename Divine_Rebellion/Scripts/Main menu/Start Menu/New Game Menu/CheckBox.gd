extends Sprite2D

@onready var animation = $Animation
@onready var on = false

func _ready():
	animation.play("off")

func _on_check_box_button_pressed():
	on = !on
	if on == false:
		animation.play("off")
	else:
		animation.play("on")
