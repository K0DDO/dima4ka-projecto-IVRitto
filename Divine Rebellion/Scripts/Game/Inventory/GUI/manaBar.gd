extends TextureProgressBar

@export var player: Player

func _ready():
	_on_player_mana_changed()

func _on_player_mana_changed():
	value = player.currentMana
