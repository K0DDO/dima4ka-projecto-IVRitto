extends Node2D

@export var speed: int = 30
@export var friction: int = 15

@onready var label = $Label

var shift_direction: Vector2 = Vector2.ZERO

func _ready():
	shift_direction = Vector2(randi_range(-1, 1), randi_range(-1, 1))
	
func _process(delta):
	global_position += speed * shift_direction * delta
	speed = max(speed - friction * delta, 0)
