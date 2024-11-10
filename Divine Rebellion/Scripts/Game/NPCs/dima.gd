extends CharacterBody2D

@export var target: Node2D

@onready var animation = $Sprite2D/Animation
@onready var navigation_agent_2d = $Navigation/NavigationAgent2D
@onready var pupupu = $Area2D/pupupu
@onready var player = $"../Player"
@onready var dialog = $Sprite2D/Node2D
@onready var task = $"../Player/CanvasLayer/Tasks menu"

var speed = 50
var acceleration = 7
var direction = "down"
var moving = true
var target_reach_distance = 1
var in_area = false
var message = 0

func _ready():
	dialog.visible = false
	task.visible = Global.taskv

func _physics_process(delta):
	if moving and target != null:
		var move_direction = Vector2.ZERO
		move_direction = navigation_agent_2d.get_next_path_position() - global_position
		move_direction = move_direction.normalized()
		
		velocity = velocity.lerp(move_direction * speed, acceleration * delta)
		move_and_slide()
		
		if global_position.distance_to(target.global_position) < target_reach_distance:
			queue_free()
	else:
		rotate_to_player(player)
	updateAnimation()

func _on_recalc_timer_timeout():
	if moving and navigation_agent_2d and target:
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
	if abs(to_target.x) > abs(to_target.y):
		direction = "left" if to_target.x < 0 else "right"
	else:
		direction = "up" if to_target.y < 0 else "down"
	animation.play("idle_" + direction)

func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		in_area = true
		moving = false
		rotate_to_player(player)

func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		in_area = false
		moving = true
		dialog.visible = false

func _input(_event):
	if !Global.taskv:
		if Input.is_action_just_pressed("attack") and in_area and message == 0:
			dialog.visible = true
			message = 1
		elif Input.is_action_just_pressed("attack") and in_area and message == 1:
			dialog.visible = false
			task.visible = true
			Global.taskv = true
			message = 2
	if Input.is_action_just_pressed("attack") and in_area and message == 2:
		if Global.mobdead >= 5:
			Global.currentmoney += 250
			Global.totalwealth += 250
			task.visible = false
			Global.taskv = false
			message = 2
