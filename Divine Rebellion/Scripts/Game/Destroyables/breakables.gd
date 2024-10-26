extends StaticBody2D

@export var item: PackedScene
@export var EFFECT_DIE: PackedScene = null

var maxHealth = 5
var currentHealth = maxHealth

func damaged():
	currentHealth -= 1
	if currentHealth <= 0:
		spawn_effect(item)
		spawn_effect(item)
		spawn_effect(EFFECT_DIE)
		queue_free()

func breakableWithPickaxe():
	pass

func spawn_effect(EFFECT: PackedScene, effect_position: Vector2 = global_position):
	if EFFECT:
		var effect = EFFECT.instantiate()
		get_tree().current_scene.call_deferred("add_child", effect)
		effect.global_position = effect_position
		effect.global_position.y = effect_position.y - 5
		return effect
