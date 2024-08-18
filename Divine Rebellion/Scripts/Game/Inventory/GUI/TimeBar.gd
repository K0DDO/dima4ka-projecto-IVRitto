extends Control

@onready var hours_label = $Time/Hours
@onready var minutes_label = $Time/minutes
@onready var day_label = $Date/Day
@onready var day_of_the_week_label = $Date/Day2
@onready var year_label = $Year/Count

func _on_time_system_update(date_time: DateTime) -> void:
	update_label(hours_label, date_time.hours)
	update_label(minutes_label, date_time.minutes)
	update_label(day_label, date_time.days+1)
	update_label(year_label, date_time.years, false)
	update_text_label(day_of_the_week_label, date_time.days)

func add_leading_zero(label: Label, value: int) -> void:
	if value < 10:
		label.text += "0"
	
func update_label(label: Label, value: int, should_have_zero: bool = true) -> void:
	label.text = ""
	
	if should_have_zero:
		add_leading_zero(label, value)
	
	label.text += str(value)

func update_text_label(label: Label, value: int) -> void:
	if value % 7 == 1:
		label.text = "Mon."
	elif value % 7 == 2:
		label.text = "Tue."
	elif value % 7 == 3:
		label.text = "Wed."
	elif value % 7 == 4:
		label.text = "Thu."
	elif value % 7 == 5:
		label.text = "Fri."
	elif value % 7 == 6:
		label.text = "Sat."
	elif value % 7 == 0:
		label.text = "Sun."
	
