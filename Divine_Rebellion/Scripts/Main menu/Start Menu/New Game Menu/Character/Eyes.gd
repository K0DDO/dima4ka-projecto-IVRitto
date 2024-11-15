extends Sprite2D

func _ready():
	pass

func _process(_delta):
	set_frame_coords(Vector2i(Global.num, 0))
	material.set("shader_parameter/new_color", Global.eyescolor)
