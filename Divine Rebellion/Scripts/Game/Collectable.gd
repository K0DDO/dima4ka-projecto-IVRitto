extends Area2D

@export var itemRes: InventoryItem

var target: Node2D = null
var speed: float = 40.0
var is_flying: bool = false

func collect(inventory: Inventory):
	if inventory.can_insert_item(itemRes):
		inventory.insert(itemRes)
		queue_free()

func _physics_process(delta: float) -> void:
	if is_flying and target:
		var direction = (target.global_position - global_position).normalized()
		position += direction * speed * delta

func _on_fly_to_the_player_body_entered(body: Node) -> void:
	if body.has_method("player"):
		target = body
		is_flying = true

func _on_fly_to_the_player_body_exited(body: Node) -> void:
	if body.has_method("player"):
		is_flying = false
		target = null
