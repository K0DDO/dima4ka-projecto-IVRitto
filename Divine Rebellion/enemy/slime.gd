extends CharacterBody2D

@export var speed = 20

var player_chase = false
var player = null
var direction = "Down"
var ani = "idle"

@onready var animation = $Animation
	
func updateAnimation():
	if velocity == Vector2.ZERO:
		ani = "idle"
	else:
		ani = "walk"
		if velocity.x > 0 and abs(velocity.y) < abs(velocity.x):
			direction = "Right"
		elif velocity.x < 0 and abs(velocity.y) < abs(velocity.x):
			direction = "Left"
		elif velocity.y < 0:
			direction = "Up"
		elif velocity.y > 0:
			direction = "Down"
	var pl = ani + direction
	animation.play(pl)

func _physics_process(_delta):
	velocity = Vector2.ZERO
	if player_chase:
		velocity = position.direction_to(player.position) * speed * 2

	move_and_slide()
	updateAnimation()


func _on_detaction_area_body_entered(body):
	player = body
	player_chase = true


func _on_detaction_area_body_exited(_body):
	player = null
	player_chase = false
	

