extends ItemList

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("Inventory") != false:
		get_tree().paused = false
		process_mode = Node.PROCESS_MODE_DISABLED
