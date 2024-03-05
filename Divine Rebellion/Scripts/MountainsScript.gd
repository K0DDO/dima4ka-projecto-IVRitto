extends Sprite2D

func _process(delta):
	if position.y <= 16:
		position.y += 1.5 * delta

func _input(event):
	if event is InputEventMouseButton:
		position.y = 16.5
