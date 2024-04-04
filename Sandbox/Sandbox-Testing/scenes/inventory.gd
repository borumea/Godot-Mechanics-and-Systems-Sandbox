extends CanvasLayer

@onready var hotbar = get_node("/root/Main/Menus/Hotbar")

var start : bool
var item_array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Menus")
	$Menu/ItemList.clear()
	process_mode = Node.PROCESS_MODE_DISABLED
	start = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if start:
		if Input.is_action_just_released("Inventory") != false or Input.is_action_just_released("Pause_Back") != false:
			get_tree().paused = false
			hide()
			start = false
			process_mode = Node.PROCESS_MODE_DISABLED

func _on_open_timer_timeout():
	start = true

func add(item, texture):
	var flag = false
	for thing in item_array: #Find the thing
		if thing.nickname == item.nickname:
			thing.frequency += 1
			flag = thing
			break
	
	if flag: #If thing exists, update text
		$Menu/ItemList.set_item_text(flag.index, str(flag.nickname) + " X" + str(flag.frequency))
	else: #Else add it
		flag = $Menu/ItemList.add_item(item.nickname + " X1", texture, true)
		var new_thing = InventoryItem.new(item.nickname, 1, flag)
		item_array.append(new_thing)
	item.queue_free() #free item memory
	
class InventoryItem: #Custom class used to keep track of all items within the inventory
	var nickname : String
	var frequency : int
	var index : int
	func _init(n, f, i):
		nickname = n
		frequency = f
		index = i
