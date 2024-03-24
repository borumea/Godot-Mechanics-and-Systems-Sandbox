extends Node

var wave : int
var max_enemies : int
var lives : int

var difficulty : float
const DIFF_MULTIPLIER : float = 1.2

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()
	$GameOver/Restart.pressed.connect(new_game)

func new_game():
	wave = 1
	difficulty = 10.0
	lives = 3
	$EnemySpawner/Timer.wait_time = 1.0
	reset()
	
func reset():
	max_enemies = int(difficulty)
	$Player.reset()
	get_tree().call_group("enemies", "queue_free")
	get_tree().call_group("bullets", "queue_free")
	get_tree().call_group("items", "queue_free")
	$HUD/LivesLabel.text = "X " + str(lives)
	$HUD/WaveLabel.text = "Wave: " + str(wave)
	$HUD/GoblinLabel.text = "X " + str(max_enemies)
	$GameOver.hide()
	get_tree().paused = true
	$RestartTimer.start()
	
func _on_restart_timer_timeout():
	get_tree().paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_wave_completed():
		wave += 1
		#adjust difficulty
		difficulty *= DIFF_MULTIPLIER
		if $EnemySpawner/Timer.wait_time > 0.25:
			$EnemySpawner/Timer.wait_time -= 0.05
		get_tree().paused = true
		$WaveOverTimer.start()
		
func _on_wave_over_timer_timeout():
	reset()

func _on_enemy_spawner_hit_p():
	lives -= 1
	$HUD/LivesLabel.text = "X " + str(lives)
	get_tree().paused = true
	if lives <= 0:
		$GameOver/WavesSurvivedLabel.text = "WAVES SURVIVED: " + str(wave - 1)
		$GameOver.show()
	else:
		$WaveOverTimer.start()

func is_wave_completed():
	var all_dead = true
	var enemies = get_tree().get_nodes_in_group("enemies")
	if enemies.size() == max_enemies: #Ensure all enemies have spawned in
		for enemy in enemies: #Iterate through all enemies
			if enemy.alive: 
				all_dead = false
				break
		return all_dead
	else:
		return false
