extends Area2D

var in_zone = false

func _process(_delta):
	if in_zone:
		get_tree().change_scene_to_file("res://Scenes/Game/world/playerHouse.tscn")


func _on_body_entered(body):
	if body.has_method("player"):
		in_zone = true
		

