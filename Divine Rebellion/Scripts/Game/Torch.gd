extends Sprite2D

@onready var animation = $Animation

func _ready():
	animation.play("idle")
