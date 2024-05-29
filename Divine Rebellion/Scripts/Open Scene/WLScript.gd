extends Sprite2D

@onready var animation = $Animation
var speed = 0

func _process(delta):
	if position.x > 96:
		speed -= 5 * delta
	elif position.x > 89:
		speed += 5 * delta
	else:
		speed = 0
		ani()
	position.x += speed

func ani():
	animation.play("idle")
