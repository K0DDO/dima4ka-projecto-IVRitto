extends Sprite2D

@onready var animation = $Animation
var speed = 0
var start = false

func _ready():
	await get_tree().create_timer(0.35).timeout
	ani()

func _process(delta):
	if start:
		if position.x > 96:
			speed -= 5 * delta
		elif position.x > 89:
			speed += 5 * delta
		else:
			speed = 0
		position.x += speed

func ani():
	animation.play("idle")


func _on_open_start_of_animation():
	start = true
