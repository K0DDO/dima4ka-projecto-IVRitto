extends Area2D

@onready var door = $Door
@onready var collision_polygon_2d = $StaticBody2D/CollisionPolygon2D
@onready var notifications = $"../TileMap/Player/CanvasLayer/Notifications"

func _ready():
	collision_polygon_2d.set_deferred("disabled", false)

func _on_body_entered(body):
	if body.has_method("player"):
		if Global.got_gold_key:
			door.visible = false
			collision_polygon_2d.set_deferred("disabled", true)
		else:
			notifications.showNotification(notifications.locked)

func _on_body_exited(body):
	if body.has_method("player"):
		door.visible = true
		collision_polygon_2d.set_deferred("disabled", false)
