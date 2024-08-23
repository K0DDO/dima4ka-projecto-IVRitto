extends CharacterBody2D

class_name Player
signal healthChanged

@onready var hair = $Hair
@onready var body = $Body
@onready var animation = $Animation
@onready var eyes = $Eyes
@onready var effects = $Effects
@onready var hurtBox = $hitbox


@export var knockbackPower: int = 500
@export var maxHealth = 100

@export var inventory: Inventory

var speed : int = 70
var direction = "Down"

var currentHealth : int = maxHealth

var isHurt : bool = false
var knockback = Vector2.ZERO
var enemy_inattack_range : bool = false
var enemy_attack_cooldown = true
var player_alive = true
var attack_ip = false


func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection * speed

func updateAnimation():
	if !attack_ip:
		if velocity.length() == 0:
			animation.play("idle" + direction)
		else:
			direction = "Down"
			if velocity.x < 0: direction = "Left"
			elif velocity.x > 0: direction = "Right"
			elif velocity.y < 0: direction = "Up"

			animation.play("walk" + direction)

func handleCollison():
	for i in get_slide_collision_count():
		var collisoin = get_slide_collision(i)
		var collider = collisoin.get_collider()

func _physics_process(_delta):
	enemy_attack()
	handleInput()
	attack()
	if !attack_ip:
		move_and_slide()
	handleCollison()
	updateAnimation()
	if !isHurt:
		for area in hurtBox.get_overlapping_areas():
			if area.name == "hitBox":
				hurtByEnemy(area)
		

func _ready():
	effects.play("RESET")
	hair.material.set("shader_parameter/new_color1", Global.haircolor)
	hair.material.set("shader_parameter/new_color2", Global.acccolor)
	eyes.material.set("shader_parameter/new_color", Global.eyescolor)
	animation.get_animation("idleDown").track_set_key_value(0, 0,Vector2(0, Global.bodybutton))
	animation.get_animation("idleLeft").track_set_key_value(0, 0,Vector2(1, Global.bodybutton))
	animation.get_animation("idleUp").track_set_key_value(0, 0,Vector2(2, Global.bodybutton))
	animation.get_animation("idleRight").track_set_key_value(0, 0,Vector2(3, Global.bodybutton))
	animation.get_animation("walkDown").track_set_key_value(0, 0,Vector2(5, Global.bodybutton))
	animation.get_animation("walkDown").track_set_key_value(0, 1,Vector2(6, Global.bodybutton))
	animation.get_animation("walkDown").track_set_key_value(0, 2,Vector2(7, Global.bodybutton))
	animation.get_animation("walkDown").track_set_key_value(0, 3,Vector2(4, Global.bodybutton))
	animation.get_animation("walkUp").track_set_key_value(0, 0,Vector2(9, Global.bodybutton))
	animation.get_animation("walkUp").track_set_key_value(0, 1,Vector2(10, Global.bodybutton))
	animation.get_animation("walkUp").track_set_key_value(0, 2,Vector2(11, Global.bodybutton))
	animation.get_animation("walkUp").track_set_key_value(0, 3,Vector2(8, Global.bodybutton))
	animation.get_animation("walkLeft").track_set_key_value(0, 0,Vector2(13, Global.bodybutton))
	animation.get_animation("walkLeft").track_set_key_value(0, 1,Vector2(14, Global.bodybutton))
	animation.get_animation("walkLeft").track_set_key_value(0, 2,Vector2(15, Global.bodybutton))
	animation.get_animation("walkLeft").track_set_key_value(0, 3,Vector2(12, Global.bodybutton))
	animation.get_animation("walkRight").track_set_key_value(0, 0,Vector2(17, Global.bodybutton))
	animation.get_animation("walkRight").track_set_key_value(0, 1,Vector2(18, Global.bodybutton))
	animation.get_animation("walkRight").track_set_key_value(0, 2,Vector2(19, Global.bodybutton))
	animation.get_animation("walkRight").track_set_key_value(0, 3,Vector2(16, Global.bodybutton))
	
	animation.get_animation("idleDown").track_set_key_value(1, 0,Vector2(0, Global.hairbutton))
	animation.get_animation("idleLeft").track_set_key_value(1, 0,Vector2(1, Global.hairbutton))
	animation.get_animation("idleUp").track_set_key_value(1, 0,Vector2(2, Global.hairbutton))
	animation.get_animation("idleRight").track_set_key_value(1, 0,Vector2(3, Global.hairbutton))
	animation.get_animation("walkDown").track_set_key_value(1, 0,Vector2(5, Global.hairbutton))
	animation.get_animation("walkDown").track_set_key_value(1, 1,Vector2(6, Global.hairbutton))
	animation.get_animation("walkDown").track_set_key_value(1, 2,Vector2(7, Global.hairbutton))
	animation.get_animation("walkDown").track_set_key_value(1, 3,Vector2(4, Global.hairbutton))
	animation.get_animation("walkUp").track_set_key_value(1, 0,Vector2(9, Global.hairbutton))
	animation.get_animation("walkUp").track_set_key_value(1, 1,Vector2(10, Global.hairbutton))
	animation.get_animation("walkUp").track_set_key_value(1, 2,Vector2(11, Global.hairbutton))
	animation.get_animation("walkUp").track_set_key_value(1, 3,Vector2(8, Global.hairbutton))
	animation.get_animation("walkLeft").track_set_key_value(1, 0,Vector2(13, Global.hairbutton))
	animation.get_animation("walkLeft").track_set_key_value(1, 1,Vector2(14, Global.hairbutton))
	animation.get_animation("walkLeft").track_set_key_value(1, 2,Vector2(15, Global.hairbutton))
	animation.get_animation("walkLeft").track_set_key_value(1, 3,Vector2(12, Global.hairbutton))
	animation.get_animation("walkRight").track_set_key_value(1, 0,Vector2(17, Global.hairbutton))
	animation.get_animation("walkRight").track_set_key_value(1, 1,Vector2(18, Global.hairbutton))
	animation.get_animation("walkRight").track_set_key_value(1, 2,Vector2(19, Global.hairbutton))
	animation.get_animation("walkRight").track_set_key_value(1, 3,Vector2(16, Global.hairbutton))
	
	animation.get_animation("idleDown").track_set_key_value(2, 0,Vector2(0, Global.topbutton))
	animation.get_animation("idleLeft").track_set_key_value(2, 0,Vector2(1, Global.topbutton))
	animation.get_animation("idleUp").track_set_key_value(2, 0,Vector2(2, Global.topbutton))
	animation.get_animation("idleRight").track_set_key_value(2, 0,Vector2(3, Global.topbutton))
	animation.get_animation("walkDown").track_set_key_value(2, 0,Vector2(5, Global.topbutton))
	animation.get_animation("walkDown").track_set_key_value(2, 1,Vector2(6, Global.topbutton))
	animation.get_animation("walkDown").track_set_key_value(2, 2,Vector2(7, Global.topbutton))
	animation.get_animation("walkDown").track_set_key_value(2, 3,Vector2(4, Global.topbutton))
	animation.get_animation("walkUp").track_set_key_value(2, 0,Vector2(9, Global.topbutton))
	animation.get_animation("walkUp").track_set_key_value(2, 1,Vector2(10, Global.topbutton))
	animation.get_animation("walkUp").track_set_key_value(2, 2,Vector2(11, Global.topbutton))
	animation.get_animation("walkUp").track_set_key_value(2, 3,Vector2(8, Global.topbutton))
	animation.get_animation("walkLeft").track_set_key_value(2, 0,Vector2(13, Global.topbutton))
	animation.get_animation("walkLeft").track_set_key_value(2, 1,Vector2(14, Global.topbutton))
	animation.get_animation("walkLeft").track_set_key_value(2, 2,Vector2(15, Global.topbutton))
	animation.get_animation("walkLeft").track_set_key_value(2, 3,Vector2(12, Global.topbutton))
	animation.get_animation("walkRight").track_set_key_value(2, 0,Vector2(17, Global.topbutton))
	animation.get_animation("walkRight").track_set_key_value(2, 1,Vector2(18, Global.topbutton))
	animation.get_animation("walkRight").track_set_key_value(2, 2,Vector2(19, Global.topbutton))
	animation.get_animation("walkRight").track_set_key_value(2, 3,Vector2(16, Global.topbutton))
	
	animation.get_animation("idleDown").track_set_key_value(3, 0,Vector2(0, Global.bottombutton))
	animation.get_animation("idleLeft").track_set_key_value(3, 0,Vector2(1, Global.bottombutton))
	animation.get_animation("idleUp").track_set_key_value(3, 0,Vector2(2, Global.bottombutton))
	animation.get_animation("idleRight").track_set_key_value(3, 0,Vector2(3, Global.bottombutton))
	animation.get_animation("walkDown").track_set_key_value(3, 0,Vector2(5, Global.bottombutton))
	animation.get_animation("walkDown").track_set_key_value(3, 1,Vector2(6, Global.bottombutton))
	animation.get_animation("walkDown").track_set_key_value(3, 2,Vector2(7, Global.bottombutton))
	animation.get_animation("walkDown").track_set_key_value(3, 3,Vector2(4, Global.bottombutton))
	animation.get_animation("walkUp").track_set_key_value(3, 0,Vector2(9, Global.bottombutton))
	animation.get_animation("walkUp").track_set_key_value(3, 1,Vector2(10, Global.bottombutton))
	animation.get_animation("walkUp").track_set_key_value(3, 2,Vector2(11, Global.bottombutton))
	animation.get_animation("walkUp").track_set_key_value(3, 3,Vector2(8, Global.bottombutton))
	animation.get_animation("walkLeft").track_set_key_value(3, 0,Vector2(13, Global.bottombutton))
	animation.get_animation("walkLeft").track_set_key_value(3, 1,Vector2(14, Global.bottombutton))
	animation.get_animation("walkLeft").track_set_key_value(3, 2,Vector2(15, Global.bottombutton))
	animation.get_animation("walkLeft").track_set_key_value(3, 3,Vector2(12, Global.bottombutton))
	animation.get_animation("walkRight").track_set_key_value(3, 0,Vector2(17, Global.bottombutton))
	animation.get_animation("walkRight").track_set_key_value(3, 1,Vector2(18, Global.bottombutton))
	animation.get_animation("walkRight").track_set_key_value(3, 2,Vector2(19, Global.bottombutton))
	animation.get_animation("walkRight").track_set_key_value(3, 3,Vector2(16, Global.bottombutton))
	
	animation.get_animation("idleDown").track_set_key_value(4, 0,Vector2(0, Global.bootsbutton))
	animation.get_animation("idleLeft").track_set_key_value(4, 0,Vector2(1, Global.bootsbutton))
	animation.get_animation("idleUp").track_set_key_value(4, 0,Vector2(2, Global.bootsbutton))
	animation.get_animation("idleRight").track_set_key_value(4, 0,Vector2(3, Global.bootsbutton))
	animation.get_animation("walkDown").track_set_key_value(4, 0,Vector2(5, Global.bootsbutton))
	animation.get_animation("walkDown").track_set_key_value(4, 1,Vector2(6, Global.bootsbutton))
	animation.get_animation("walkDown").track_set_key_value(4, 2,Vector2(7, Global.bootsbutton))
	animation.get_animation("walkDown").track_set_key_value(4, 3,Vector2(4, Global.bootsbutton))
	animation.get_animation("walkUp").track_set_key_value(4, 0,Vector2(9, Global.bootsbutton))
	animation.get_animation("walkUp").track_set_key_value(4, 1,Vector2(10, Global.bootsbutton))
	animation.get_animation("walkUp").track_set_key_value(4, 2,Vector2(11, Global.bootsbutton))
	animation.get_animation("walkUp").track_set_key_value(4, 3,Vector2(8, Global.bootsbutton))
	animation.get_animation("walkLeft").track_set_key_value(4, 0,Vector2(13, Global.bootsbutton))
	animation.get_animation("walkLeft").track_set_key_value(4, 1,Vector2(14, Global.bootsbutton))
	animation.get_animation("walkLeft").track_set_key_value(4, 2,Vector2(15, Global.bootsbutton))
	animation.get_animation("walkLeft").track_set_key_value(4, 3,Vector2(12, Global.bootsbutton))
	animation.get_animation("walkRight").track_set_key_value(4, 0,Vector2(17, Global.bootsbutton))
	animation.get_animation("walkRight").track_set_key_value(4, 1,Vector2(18, Global.bootsbutton))
	animation.get_animation("walkRight").track_set_key_value(4, 2,Vector2(19, Global.bootsbutton))
	animation.get_animation("walkRight").track_set_key_value(4, 3,Vector2(16, Global.bootsbutton))

func hurtByEnemy(area):
	if !isHurt:
		isHurt = true
		currentHealth -= 5
		healthChanged.emit()
		print("Current Health: ", currentHealth)
		effects.play("hurtBlink")
		
		var enemy_position = area.global_position
		var direction_to_enemy = global_position.direction_to(enemy_position)
		var knockback_strength = knockbackPower
		var knockback_direction = -direction_to_enemy * knockback_strength

		var knockback_duration = 0.3
		var elapsed_time = 0.0

		if abs(knockback_direction.y) > abs(knockback_direction.x):
			while elapsed_time < knockback_duration:
				var t = elapsed_time / knockback_duration
				velocity = knockback_direction * (1.0 - t)
				move_and_slide()
				await get_tree().create_timer(0.01).timeout
				elapsed_time += 0.01
		else:
			while elapsed_time < knockback_duration:
				var t = elapsed_time / knockback_duration
				var horizontal_knockback = knockback_direction * (1.0 - t)
				var vertical_knockback = Vector2(0, 1.5 * knockback_strength * t * (1.0 - t))

				velocity = horizontal_knockback + vertical_knockback
				move_and_slide()
				await get_tree().create_timer(0.01).timeout
				elapsed_time += 0.01

		velocity = Vector2.ZERO
		await get_tree().create_timer(0.5).timeout
		isHurt = false
		effects.play("RESET")


func _on_collecting_area_entered(area):
	if area.has_method("collect"):
			area.collect(inventory)

func _on_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true

func _on_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false

func player():
	pass

func attack():
	if Input.is_action_just_pressed("attack"):
		attack_ip = true
		animation.play("attack" + direction)
		await animation.animation_finished
		attack_ip = false

func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown:
		hurtByEnemy(hurtBox)
		enemy_attack_cooldown = false
		await get_tree().create_timer(2).timeout
		enemy_attack_cooldown = true
