extends CharacterBody2D

const indicator_damage = preload("res://Scenes/Game/resources/damage_indicator.tscn")

@onready var health_bar = $Sprite/health
@onready var animation = $Animation

@export var speed = 20
@export var wander_radius = 50
@export var wander_time = 5
@export var knockbackPower = 100
@export var EFFECT_DIED: PackedScene = null

var player_chase = false
var player = null
var direction = "Down"
var ani = "idle"

var maxHealth = 15
var currentHealth = maxHealth


var original_position: Vector2
var target_position: Vector2
var wander_timer = 0.0

var isHurt = false
var isAlive = true

func _ready():
	original_position = global_position
	set_new_wander_target()
	update()

func updateAnimation():
	if isAlive:
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

func _physics_process(delta):
	if isAlive:
		if isHurt:
			move_and_slide()
		else:
			velocity = Vector2.ZERO
			if player_chase:
				var pos = position
				velocity = position.direction_to(player.position) * speed * 2
				if player.position.distance_to(position) > 20:
					move_and_slide()
				else:
					position = pos
			else:
				wander_timer -= delta
				if wander_timer <= 0.0:
					set_new_wander_target()
				
				if global_position.distance_to(target_position) > 5:
					velocity = global_position.direction_to(target_position) * speed
					move_and_slide()

	updateAnimation()

func set_new_wander_target():
	var random_offset = Vector2(randf_range(-wander_radius, wander_radius), randf_range(-wander_radius, wander_radius))
	target_position = original_position + random_offset
	wander_timer = wander_time

func _on_detaction_area_body_entered(body):
	player = body
	player_chase = true

func _on_detaction_area_body_exited(_body):
	player = null
	player_chase = false

func enemy():
	pass
	
func update():
	health_bar.value = currentHealth

func hurtByPlayer(character):
	if !isHurt:
		isHurt = true
		var dmg = 5
		currentHealth -= dmg
		spawn_dmgindicator(dmg)
		update()
		if currentHealth <= 0:
			isAlive = false
			animation.stop()
			animation.play("die")
			await animation.animation_finished
			spawn_effect(EFFECT_DIED)
			queue_free()

		var player_position = character.global_position
		var direction_to_player = global_position.direction_to(player_position)
		var knockback_strength = knockbackPower
		var knockback_direction = -direction_to_player * knockback_strength
		var knockback_duration = 0.3
		var elapsed_time = 0.0

		while elapsed_time < knockback_duration:
			var t = elapsed_time / knockback_duration
			velocity = knockback_direction * (1.0 - t)
			move_and_slide()
			await get_tree().create_timer(0.01).timeout
			elapsed_time += 0.01

		velocity = Vector2.ZERO
		await get_tree().create_timer(0.5).timeout
		isHurt = false
		
func spawn_effect(EFFECT: PackedScene, effect_position: Vector2 = global_position):
	if EFFECT:
		var effect = EFFECT.instantiate()
		get_tree().current_scene.add_child(effect)
		effect.global_position = effect_position
		return effect

func spawn_dmgindicator(damage: int):
	var indicator = spawn_effect(indicator_damage)
	if indicator:
		indicator.label.text = str(damage)
