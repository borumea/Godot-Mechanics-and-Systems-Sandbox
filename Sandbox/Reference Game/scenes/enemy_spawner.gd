extends Node2D

@onready var main = get_node('/root/Main')

signal hit_p

var goblin_scene := preload('res://scenes/goblin.tscn')
var spawn_points := []

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is Marker2D:
			spawn_points.append(child)

func _on_timer_timeout():
	#Check how many enemies have been created and compare to main max_enemies
	var enemies = get_tree().get_nodes_in_group("enemies")
	if enemies.size() < get_parent().max_enemies:
		#pick random spawn point
		var spawn = spawn_points[randi() % spawn_points.size()]
		#spawn enemy based on point
		var goblin = goblin_scene.instantiate()
		goblin.position = spawn.position
		goblin.hit_player.connect(hit)
		main.add_child(goblin)
		goblin.add_to_group("enemies")
	
func hit():
	hit_p.emit()
