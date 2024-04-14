extends Sprite2D

func _ready():
	pass

func _process(_delta):
	set_frame_coords(Vector2i(Global.num, Global.bodybutton - 1))
