extends Node

var in_loading_zone : bool
var in_pause_menu : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_tree().set_auto_accept_quit(false) #User must complete proper quit
	in_loading_zone = false
	in_pause_menu = false
	
	for child in $Tilemaps.get_children(): #Hide all other tilemaps and menus
		if child is TileMap and child != $Tilemaps/Overworld:
			child.add_to_group("TileMaps")
			child.hide()
	
	for child in $Menus.get_children(): #Hide all menus aside from StartMenu
		if child is CanvasLayer and child != $Menus/StartMenu:
			child.hide()

	get_tree().paused = true #Pause game because we are starting on a menu

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Camera2D.position = $Player.position
	check_inputs()
	
func _notification(what): #function to handle notifications sent through the tree
	if what == NOTIFICATION_WM_CLOSE_REQUEST: #This is the close notification
		save_and_quit()

func check_inputs():
	if Input.is_action_just_released("Pause_Back") != false:
		$Menus/PauseMenu.process_mode = Node.PROCESS_MODE_ALWAYS
		$Menus/PauseMenu.show()
		$Menus/PauseMenu/OpenTimer.start()
		get_tree().paused = true
	
	elif Input.is_action_just_released("Inventory") != false:
		$Menus/Inventory.process_mode = Node.PROCESS_MODE_ALWAYS
		$Menus/Inventory.show()
		$Menus/Inventory/OpenTimer.start()
		get_tree().paused = true

func save_and_quit():
	pass

#Handle loading zones below
func _on_dungeon_1_entrance_body_entered(body):
	if not in_loading_zone:
		body.position = $LoadingZones/Dungeon1_Exit/Dungeon1_Exit.position
		in_loading_zone = true
		$Tilemaps/Dungeon_1.show()
		$Tilemaps/Overworld.hide()

func _on_dungeon_1_entrance_body_exited(_body):
	in_loading_zone = false

func _on_dungeon_1_exit_body_entered(body):
	if not in_loading_zone:
		body.position = $LoadingZones/Dungeon1_Entrance/Dungeon1_Entrance.position
		in_loading_zone = true
		$Tilemaps/Dungeon_1.hide()
		$Tilemaps/Overworld.show()

func _on_dungeon_1_exit_body_exited(_body):
	in_loading_zone = false
