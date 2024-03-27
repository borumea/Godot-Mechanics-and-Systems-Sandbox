extends Node

var in_loading_zone : bool
# Called when the node enters the scene tree for the first time.
func _ready():
	in_loading_zone = false
	for child in get_children():
		if child is TileMap and child != $Overworld:
			child.add_to_group("TileMaps")
			child.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Camera2D.position = $Player.position

#Handle loading zones below

func _on_dungeon_1_entrance_body_entered(body):
	if not in_loading_zone:
		body.position = $Dungeon1_Exit/Dungeon1_Exit.position
		in_loading_zone = true
		$Dungeon_1.show()
		$Overworld.hide()

func _on_dungeon_1_entrance_body_exited(_body):
	in_loading_zone = false

func _on_dungeon_1_exit_body_entered(body):
	if not in_loading_zone:
		body.position = $Dungeon1_Entrance/Dungeon1_Entrance.position
		in_loading_zone = true
		$Dungeon_1.hide()
		$Overworld.show()

func _on_dungeon_1_exit_body_exited(_body):
	in_loading_zone = false
