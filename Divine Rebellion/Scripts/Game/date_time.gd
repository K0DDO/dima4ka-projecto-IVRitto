class_name DateTime extends Resource

@export_range(0, 59) var seconds: int = 0
@export_range(0, 59) var minutes: int = 0
@export_range(0, 23) var hours: int = 0
@export_range(0, 28) var days: int = 0
@export_range(1, 4) var season: int = 0
@export var years: int = 1

var delta_time: float = 0

func increase_by_sec(delta_seconds: float) -> void:
	delta_time += delta_seconds
	if delta_time < 1: return
	
	var delta_int_secs: int = delta_time
	delta_time -= delta_int_secs
	
	seconds += delta_int_secs
	minutes += seconds / 60
	hours += minutes / 60
	days += hours / 24
	season += days / 28
	years += season / 4
	
	seconds = seconds % 60
	minutes = minutes % 60
	hours = hours % 24
	days = days % 28

	season = season % 4
	
	Global.day = days + 1
	Global.season = season
	Global.year = years
	
