extends Node2D

@export var player: Player
@onready var door_spawn_position = $DoorSpawnPosition
@onready var stairs_first_floor_spawn_position = $StairsFirstFloorSpawnPosition
@onready var stairs_basement_spawn_position = $StairsBasementSpawnPosition

func _ready():
	match Global.entry_point:
		Global.EntryPoint.DOOR:
			player.global_position = door_spawn_position.global_position
		Global.EntryPoint.STAIRS_FIRST_FLOOR:
			player.global_position = stairs_first_floor_spawn_position.global_position
		Global.EntryPoint.STAIRS_BASEMENT:
			player.global_position = stairs_basement_spawn_position.global_position
