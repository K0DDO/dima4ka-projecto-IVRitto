extends CharacterBody2D

@onready var hair = $Hair
@onready var body = $Body
@onready var animation = $Animation
@onready var eyes = $Eyes
@onready var effects = $Effects
@onready var hurtBox = $hurtBox


@export var knockbackPower: int = 500
@export var maxHealth = 3

@export var inventory: Inventory

var speed : int = 70
var direction = "Down"
var currentHealth : int = maxHealth
var isHurt : bool = false
var knockback = Vector2.ZERO

func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection * speed

func updateAnimation():
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
		print_debug(collider.name)

func _physics_process(_delta):

	handleInput()
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

func hurtByEnemy(_area):
	currentHealth -= 1
	if currentHealth < 0:
		currentHealth = maxHealth
	isHurt = true
	effects.play("hurtBlink")
	await get_tree().create_timer(1).timeout
	effects.play("RESET")
	isHurt = false
	#knockback(area.get_parent().velocity)
	
func _on_hit_box_area_entered(area):
	if area.has_method("collect"):
		area.collect(inventory)


func _on_hurt_box_area_exited(_area):
	pass
