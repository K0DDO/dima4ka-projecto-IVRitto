extends CharacterBody2D

@export var speed = 20

var player_chase = false
var player = null
var direction = "Down"
var ani = "idle"

var health = 15
var player_inattack_zone = false

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
	
	deal_with_damage()
	
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
	
func enemy():
	pass


func _on_hit_box_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true


func _on_hit_box_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false

func deal_with_damage():
	if player_inattack_zone and Global.player_current_atack:
		health = health - 10
		if health <= 0:
			self.queue_free()
