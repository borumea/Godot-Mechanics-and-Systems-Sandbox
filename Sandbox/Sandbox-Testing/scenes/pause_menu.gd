extends CanvasLayer

@onready var start_menu = get_node("/root/Main/Menus/StartMenu")
@onready var options_menu = get_node("/root/Main/Menus/OptionsMenu")

var start : bool
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Menus")
	process_mode = Node.PROCESS_MODE_DISABLED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if start:
		if Input.is_action_just_released("Pause_Back") != false:
			get_tree().paused = false
			hide()
			start = false
			process_mode = Node.PROCESS_MODE_DISABLED

func _on_quit_to_main_menu_button_up():
	hide()
	start = false
	start_menu.process_mode = Node.PROCESS_MODE_ALWAYS
	start_menu.show()
	process_mode = Node.PROCESS_MODE_DISABLED

func _on_save_and_quit_button_up():
	#Send notification to all nodes to clean up, then quit
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()

func _on_options_button_up():
	options_menu.process_mode = Node.PROCESS_MODE_ALWAYS
	options_menu.show()

func _on_open_timer_timeout():
	start = true
