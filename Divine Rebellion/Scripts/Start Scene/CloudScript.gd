extends ParallaxLayer
	
func _physics_process(delta):
	motion_offset = Global.coords
	Global.coords.x += 5 * delta

func _on_clouds_ready():
	motion_offset = Global.coords
	visible = not visible
