extends Sprite2D

@onready var animation = $Animation

func _ready():
	await get_tree().create_timer(0.35).timeout
	visible = not visible
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://Scenes/start_scene.tscn")

func _process(_delta):
	animation.play("idle")
