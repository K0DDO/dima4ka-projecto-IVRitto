class_name TimeSystem extends Node

signal update

@export var date_time: DateTime
@export var ticks_pr_second: int = 6

func _ready():
	date_time.seconds = Global.second
	date_time.minutes = Global.minute
	date_time.hours = Global.hour
	date_time.days = Global.day
	date_time.season = Global.season
	date_time.years = Global.year

func _process(delta: float) -> void:
	date_time.increase_by_sec(delta * ticks_pr_second)
	update.emit(date_time)

func save_current_time():
	Global.second = date_time.seconds
	Global.minute = date_time.minutes
	Global.hour = date_time.hours
	Global.day = date_time.days
	Global.season = date_time.season
	Global.year = date_time.years

func change_scene(new_scene: String):
	save_current_time()
	get_tree().change_scene_to_file(new_scene)
