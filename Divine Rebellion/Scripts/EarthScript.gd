extends Sprite2D

func _process(delta):
	if position.y <= 100:
		position.y += 20 * delta

func _input(event):
	if event is InputEventMouseButton:
		position.y = 100

