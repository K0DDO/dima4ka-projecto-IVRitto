extends Camera2D

func _process(delta):
	if position.y >= -125:
		position += Vector2(0, -0.2)
	
func _input(event):
	if event is InputEventMouseButton:
		position = Vector2(0, -125)
