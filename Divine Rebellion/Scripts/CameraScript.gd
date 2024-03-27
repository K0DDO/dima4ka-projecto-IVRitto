extends Camera2D

func _process(delta):
	if position.y > 160:
		position.y += -16 * delta
	
func _input(event):
	if event is InputEventMouseButton:
		position = Vector2(0, 160)
