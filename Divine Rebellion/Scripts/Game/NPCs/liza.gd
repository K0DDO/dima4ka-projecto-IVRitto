extends CharacterBody2D

@export var target: Node2D

@onready var animation = $Sprite2D/Animation
@onready var navigation_agent_2d = $Navigation/NavigationAgent2D
@onready var pupupu = $Area2D/pupupu
@onready var player = $"../Player"

var speed = 50
var acceleration = 7
var direction = "down"
var moving = true

func _physics_process(delta):
	if moving:
		var move_direction = Vector2.ZERO
		move_direction = navigation_agent_2d.get_next_path_position() - global_position
		move_direction = move_direction.normalized()
		
		velocity = velocity.lerp(move_direction * speed, acceleration * delta)
		move_and_slide()
	else:
		rotate_to_player(player)
	updateAnimation()

func _on_recalc_timer_timeout():
	if moving:
		navigation_agent_2d.target_position = target.global_position

func updateAnimation():
	if moving:
		direction = "down"
		if velocity.x < 0: direction = "left"
		elif velocity.x > 0: direction = "right"
		elif velocity.y < 0: direction = "up"
		animation.play("walk_" + direction)

func rotate_to_player(target):
	var to_target = (target.global_position - global_position).normalized()
	print(to_target)
	if abs(to_target.x) > abs(to_target.y):
		if to_target.x < 0:
			direction = "left" 
		else:
			direction = "right"
	else:
		if to_target.y < 0:
			direction = "up"
		else:
			direction = "down"
	animation.play("idle_" + direction)

func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		moving = false
		rotate_to_player(player)

func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		moving = true
