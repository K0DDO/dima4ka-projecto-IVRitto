extends Sprite2D

func _process(delta):
	if position.y <= 80:
		position.y += 4 * delta

func _input(event):
	if event is InputEventMouseButton:
		position.y = 44
