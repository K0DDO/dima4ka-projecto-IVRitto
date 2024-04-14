extends Sprite2D

func _ready():
	Global.haircolorbutton = 0

func _process(_delta):
	set_frame_coords(Vector2i(0, Global.haircolorbutton))
