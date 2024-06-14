extends Sprite2D

func _ready():
	pass

func _process(_delta):
	set_frame_coords(Vector2i(Global.num, Global.hairbutton))
	material.set("shader_parameter/new_color1", Global.haircolor)
	material.set("shader_parameter/new_color2", Global.acccolor)
