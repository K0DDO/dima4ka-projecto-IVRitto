extends Area2D

@onready var door = $Door

func _on_body_entered(body):
	if body.has_method("player"):
		door.visible = false

func _on_body_exited(body):
	if body.has_method("player"):
		door.visible = true
