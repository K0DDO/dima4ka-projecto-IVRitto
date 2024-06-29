extends Sprite2D

@onready var silhouette = $silhouette

func _ready():
	silhouette.texture = texture
	silhouette.offset = offset
	silhouette.flip_h = flip_h
	silhouette.hframes = hframes
	silhouette.vframes = vframes
	silhouette.frame = frame

func _set(property, value):
	if is_instance_valid(silhouette):
		match property:
			"texture":
				silhouette.texture = value
			"offset":
				silhouette.offset = value
			"flip_h":
				silhouette.flip_h = value
			"hframes":
				silhouette.hframes = value
			"vframes":
				silhouette.vframes = value
			"frame":
				silhouette.frame = value
		return false
