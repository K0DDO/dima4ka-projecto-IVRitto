extends TextureProgressBar

@export var player: Player

func _ready():
	player.healthChanged.connect(update)
	update()

func update():
	value = Global.currentHealth
