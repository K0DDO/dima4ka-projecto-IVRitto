extends Node

class_name TimeSystem

signal update

@export var date_time: DateTime
@export var ticks_pr_second: int = 6
@export var npc_scene: PackedScene
@onready var tilemap = $"../TileMap"

func _ready():
	date_time.seconds = Global.second
	date_time.minutes = Global.minute
	date_time.hours = Global.hour
	date_time.days = Global.day
	date_time.season = Global.season
	date_time.years = Global.year

func _process(delta: float) -> void:
	date_time.increase_by_sec(delta * ticks_pr_second)
	emit_signal("update", date_time)

func _on_time_update(current_time: DateTime) -> void:
	if current_time.hours == 12:
		spawn_npc()

func spawn_npc():
	if tilemap and npc_scene:
		var npc_instance = npc_scene.instantiate()
		npc_instance.position = Vector2(100, 200)
		tilemap.add_child(npc_instance)
		npc_instance.name = "NPC"
		print("NPC заспавнен в TileMap")

func save_current_time():
	Global.second = date_time.seconds
	Global.minute = date_time.minutes
	Global.hour = date_time.hours
	Global.day = date_time.days
	Global.season = date_time.season
	Global.year = date_time.years

func change_scene(new_scene: String):
	if new_scene != null:
		save_current_time()
		get_tree().change_scene_to_file(new_scene)

