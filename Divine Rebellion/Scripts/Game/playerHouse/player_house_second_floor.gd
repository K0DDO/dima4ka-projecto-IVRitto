extends Node2D

@onready var inventory = $Player/CanvasLayer/inventory
@onready var time_system = $TimeSystem

@export var seeds_scene: PackedScene
@export var fert_scene: PackedScene

func _on_inventory_closed():
	get_tree().paused = false

func _on_inventory_opened():
	get_tree().paused = true
	
func _ready():
	if seeds_scene:
		if time_system.date_time.hours <= 6 and time_system.date_time.days == 1 and time_system.date_time.minutes >= 0:
			for i in range(10):
				var seeds_instance = seeds_scene.instantiate()
				seeds_instance.name = "seeds_" + str(i + 1)
				$".".add_child(seeds_instance)
				seeds_instance.position = Vector2(341, 235)
			for i in range(10):
				var fert_instance = fert_scene.instantiate()
				fert_instance.name = "fert_" + str(i + 1)
				$".".add_child(fert_instance)
				fert_instance.position = Vector2(334, 221)
