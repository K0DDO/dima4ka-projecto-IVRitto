extends Resource

class_name InventoryItem

@export var name: String = ""
@export var texture: Texture2D
@export var stackSize: int
@export var itemType: String = ""

@export var recipe_items: Array[InventoryItem] = []
@export var recipe_amounts: Array[int] = []
@export var carft_amount: int = 1
@export var energy: int
@export var health: int

@export_enum("Weapon", "Material", "Food") 
var type = "Material"

@export_multiline var description: String
