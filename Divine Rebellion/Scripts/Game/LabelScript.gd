extends Label

@export var player: Node2D
@export var fade_distance: float = 100.0
@export var fade_speed: float = 10.0

var have_seen = false

func _ready() -> void:
	modulate.a = 0

func _process(delta: float) -> void:
	if !have_seen:
		var distance_to_player = global_position.distance_to(player.global_position)
		var alpha = clamp(1.0 - (distance_to_player / fade_distance), 0.0, 1.0)
		modulate.a = lerp(modulate.a, alpha, fade_speed * delta)

