extends Sprite2D

@onready var animation = $Animation

func _process(_delta):
	animation.play("idle")

func _on_open_start_of_animation():
	await get_tree().create_timer(0.35).timeout
	visible = not visible
