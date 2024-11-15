extends CharacterBody2D

@export var speed = 30
@onready var animations = $AnimatedSprite2D
var direction = "down"

func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection
	if velocity.x != 0 and velocity.y != 0:
		velocity *= sqrt(speed ** 2)
	else:
		velocity *= speed

func _physics_process(delta):
	handleInput()
	move_and_slide()
	updateAnimation()

func updateAnimation():
	if velocity.length() == 0:
		animations.play("idle_" + direction)
		animations.stop()
	else:
		if velocity.x < 0: direction = "left"
		elif velocity.x > 0: direction = "right"
		elif velocity.y < 0: direction = "up"
		elif velocity.y > 0: direction = "down"
		animations.play("walk_" + direction)
