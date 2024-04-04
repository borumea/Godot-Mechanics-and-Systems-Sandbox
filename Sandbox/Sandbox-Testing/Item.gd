extends Area2D

@onready var inventory = get_node("/root/Main/Menus/Inventory")
var type : int
var nickname : String

var wood = preload("res://Assets/items/coffee_box.png")
var stone = preload("res://Assets/items/health_box.png")
var grass = preload("res://Assets/items/gun_box.png")
var textures = [wood, stone, grass]
var names = ["Wood", "Stone", "Grass"]

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.texture = textures[type]
	nickname = names[type]
	
func _process(_delta):
	pass

func _on_body_entered(_body):
	inventory.add(self, $Sprite2D.texture)
