extends CharacterBody2D

@export var speed = 20
@onready var health_bar = $Sprite/health
@onready var animation = $Animation

var player_chase = false
var player = null
var direction = "Down"
var ani = "idle"

var maxHealth = 15
var player_inattack_zone = false
var currentHealth = maxHealth

func _ready():
	update()

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
		var pos = position
		velocity = position.direction_to(player.position) * speed * 2
		if player.position.distance_to(position) > 25:
			move_and_slide()
		else:
			position = pos
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
		currentHealth = currentHealth - 5
		if currentHealth <= 0:
			self.queue_free()
			
func update():
	health_bar.value = currentHealth

