extends Sprite2D

@onready var friendship = $"../../../Friendship"
@onready var combating = $"../../../Combating"
@onready var fishing = $"../../../Fishing"
@onready var farming = $"../../../Farming"
@onready var collecting = $"../../../Collecting"
@onready var magic = $"../../../Magic"
var enter = false

func _ready():
	pass

func _process(_delta):
	frame_coords.x = Global.skill
	if enter:
		if Global.skill == 0:
			magic.visible = false
			friendship.visible = true
		elif Global.skill == 1:
			friendship.visible = false
			combating.visible = true
		elif Global.skill == 2:
			combating.visible = false
			fishing.visible = true
		elif Global.skill == 3:
			fishing.visible = false
			farming.visible = true
		elif Global.skill == 4:
			farming.visible = false
			collecting.visible = true
		elif Global.skill == 5:
			collecting.visible = false
			magic.visible = true

func _on_skill_pressed():
	if Global.skill < 5:
		Global.skill += 1
	else:
		Global.skill = 0
	position.y += 1
	await get_tree().create_timer(0.1).timeout
	position.y -= 1

func _on_skill_mouse_entered():
	enter = true

func _on_skill_mouse_exited():
	enter = false
	friendship.visible = false
	combating.visible = false
	fishing.visible = false
	farming.visible = false
	farming.visible = false
	collecting.visible = false
	magic.visible = false
