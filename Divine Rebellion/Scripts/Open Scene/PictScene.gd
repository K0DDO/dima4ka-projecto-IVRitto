extends Sprite2D

@onready var animation = $Animation

func _ready():
	await get_tree().create_timer(0.35).timeout
	visible = not visible

func _process(_delta):
	animation.play("idle")
