extends Sprite2D

func _process(delta):
	if position.y <= 11:
		position.y += 1 * delta

func _input(event):
	if event is InputEventMouseButton:
		position.y = 11
