extends Sprite2D

var speed : Vector2 = Vector2.ZERO
var acceleration_up : Vector2 = Vector2.ZERO
var acceleration_down : Vector2 = Vector2.ZERO
var is_pressed : bool = false

func _ready():
	pass

func _input(event):
	if is_pressed == false:
		if event is InputEventMouseButton:
			is_pressed = true
			set_acceleration_up(Vector2(0, 0.1))
			set_acceleration_down(Vector2(0, 0.4))

func _process(delta):
	if position.y <= -231:
		position += speed * delta * 60
		speed += acceleration_up * delta * 60
	elif position.y <= -204:
		position += speed * delta * 60
		speed -= acceleration_down * delta * 60
		
func set_acceleration_up(new_acceleration : Vector2):
	acceleration_up = new_acceleration
	
func set_acceleration_down(new_acceleration : Vector2):
	acceleration_down = new_acceleration

func set_speed(new_speed : Vector2):
	speed = new_speed

func _on_timer_timeout():
	if is_pressed == false:
		set_acceleration_up(Vector2(0, 0.1))
		set_acceleration_down(Vector2(0, 0.4))
