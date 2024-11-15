extends Sprite2D

@onready var animations = $HairButtonAnimation
@onready var hair = $Hair

func _ready():
	animations.play("idle")
	hair.set_visible(false)

func _physics_process(_delta):
	if Global.tab != "hair":
		animations.play("idle")
		hair.set_visible(false)
	hair.material.set("shader_parameter/new_color1", Global.haircolor)
	
		
func _on_hair_button_pressed():
	animations.play("pressed")
	Global.tab = "hair"
	hair.set_visible(true)
