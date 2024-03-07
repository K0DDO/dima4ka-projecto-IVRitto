extends Camera2D

func _process(delta):
	if position.y >= -125:
		position.y += -15 * delta
	
func _input(event):
	if event is InputEventMouseButton:
		position = Vector2(0, -125)
