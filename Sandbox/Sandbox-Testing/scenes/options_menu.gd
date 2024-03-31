extends CanvasLayer

var start : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Menus")
	process_mode = Node.PROCESS_MODE_DISABLED
	start = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if start:
		if Input.is_action_just_released("Pause_Back") != false:
			exit()

func _on_open_timer_timeout():
	start = true

func _on_back_button_button_up():
	exit()
	
func exit():
	hide()
	start = false
	process_mode = Node.PROCESS_MODE_DISABLED
