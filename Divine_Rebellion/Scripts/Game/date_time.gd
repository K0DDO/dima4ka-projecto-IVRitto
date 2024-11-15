class_name DateTime extends Resource

@export_range(0, 59) var seconds: int = 0
@export_range(0, 59) var minutes: int = 0
@export_range(0, 23) var hours: int = 0
@export_range(1, 28) var days: int = 1
@export_range(1, 4) var season: int = 1
@export var years: int = 1

var delta_time: float = 0

func increase_by_sec(delta_seconds: float) -> void:
	if Global.scene != "learning":
		delta_time += delta_seconds
		if delta_time < 1: return
		
		var delta_int_secs: int = delta_time
		delta_time -= delta_int_secs
		
		seconds += delta_int_secs
		minutes += seconds / 60
		hours += minutes / 60
		days += hours / 24
		season += (days - 1) / 28
		years += (season - 1) / 4
		
		seconds = seconds % 60
		minutes = minutes % 60
		hours = hours % 24
		days = (days - 1) % 28 + 1
		season = (season - 1) % 4 + 1
		
		Global.day = days
		Global.season = season
		Global.year = years

func diff_without_days(other_time: DateTime) -> int:
	var diff_hours = hours - other_time.hours
	var diff_minutes = minutes - other_time.minutes + diff_hours * 60
	var diff_seconds = seconds - other_time.seconds + diff_minutes * 60
	
	return diff_seconds

