extends Sprite2D

@onready var animations = $HairButtonAnimation

func _ready():
	animations.play("idle")

func _physics_process(_delta):
	if Global.tab != "hair":
			animations.play("idle")
		
func _on_hair_button_pressed():
	animations.play("pressed")
	Global.tab = "hair"
