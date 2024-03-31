extends CanvasLayer

@onready var options_menu = get_node("/root/Main/Menus/OptionsMenu")

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	add_to_group("Menus")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta):
	#pass

func _on_start_button_up():
	hide()
	get_tree().paused = false
	process_mode = Node.PROCESS_MODE_DISABLED

func _on_exit_button_up():
	#Send notification to all nodes to clean up, then quit
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()

func _on_options_button_up():
	options_menu.process_mode = Node.PROCESS_MODE_ALWAYS
	options_menu.show()
