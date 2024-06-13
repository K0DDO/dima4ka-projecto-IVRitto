extends Sprite2D

func _on_color_picker_color_changed(color):
	material.set("shader_parameter/new_color1", color)
