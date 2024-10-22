extends Button

@onready var namee = $Button/Name
@onready var energy = $Button/Energy
@onready var money = $Button/Money
@onready var texture = $Button/Sprite2D

@export var resource: Resource

func _ready():
	namee.text = resource.item.name
	texture.texture = resource.big_pic
	money.text = str(resource.cost)
	energy.text = str(resource.item.energy)
