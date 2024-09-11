extends Resource

class_name InventoryItem

@export var name : String = ""
@export var texture : Texture2D
@export var stackSize: int
@export var itemType: String = ""

@export var recipe: Array[InventoryItem]
 
@export_enum("Weapon", "Material") 
var type = "Material"
 
@export_multiline var description: String
