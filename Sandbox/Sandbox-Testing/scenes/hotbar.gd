extends CanvasLayer

const max_size = 8

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Menus")
	#Need to make visible upon entering game, and invisible when going back to start menu


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
