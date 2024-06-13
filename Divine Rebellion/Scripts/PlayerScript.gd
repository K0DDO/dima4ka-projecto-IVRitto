extends CharacterBody2D

@onready var body = $Body
@onready var animation = $Animation
var speed : int = 70
var direction = "Down"
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

func _physics_process(_delta):
	handleInput()
	move_and_slide()
	updateAnimation()

func _ready():
	'
	animation.get_animation("idleDown").track_set_key_value(0, 0,Vector2(0, Global.bodybutton - 1))
	animation.get_animation("idleLeft").track_set_key_value(0, 0,Vector2(1, Global.bodybutton - 1))
	animation.get_animation("idleUp").track_set_key_value(0, 0,Vector2(2, Global.bodybutton - 1))
	animation.get_animation("idleRight").track_set_key_value(0, 0,Vector2(3, Global.bodybutton - 1))
	animation.get_animation("walkDown").track_set_key_value(0, 0,Vector2(4, Global.bodybutton - 1))
	animation.get_animation("walkDown").track_set_key_value(0, 1,Vector2(5, Global.bodybutton - 1))
	animation.get_animation("walkDown").track_set_key_value(0, 2,Vector2(6, Global.bodybutton - 1))
	animation.get_animation("walkDown").track_set_key_value(0, 3,Vector2(7, Global.bodybutton - 1))
	animation.get_animation("walkUp").track_set_key_value(0, 0,Vector2(8, Global.bodybutton - 1))
	animation.get_animation("walkUp").track_set_key_value(0, 1,Vector2(9, Global.bodybutton - 1))
	animation.get_animation("walkUp").track_set_key_value(0, 2,Vector2(10, Global.bodybutton - 1))
	animation.get_animation("walkUp").track_set_key_value(0, 3,Vector2(11, Global.bodybutton - 1))
	animation.get_animation("walkLeft").track_set_key_value(0, 0,Vector2(12, Global.bodybutton - 1))
	animation.get_animation("walkLeft").track_set_key_value(0, 1,Vector2(13, Global.bodybutton - 1))
	animation.get_animation("walkLeft").track_set_key_value(0, 2,Vector2(14, Global.bodybutton - 1))
	animation.get_animation("walkLeft").track_set_key_value(0, 3,Vector2(15, Global.bodybutton - 1))
	animation.get_animation("walkRight").track_set_key_value(0, 0,Vector2(16, Global.bodybutton - 1))
	animation.get_animation("walkRight").track_set_key_value(0, 1,Vector2(17, Global.bodybutton - 1))
	animation.get_animation("walkRight").track_set_key_value(0, 2,Vector2(18, Global.bodybutton - 1))
	animation.get_animation("walkRight").track_set_key_value(0, 3,Vector2(19, Global.bodybutton - 1))
	'
	pass

