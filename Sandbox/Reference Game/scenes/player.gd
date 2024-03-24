extends CharacterBody2D

const START_SPEED : int = 200
const BOOST_SPEED : int = 400
const NORMAL_SHOT : float = 0.5
const FAST_SHOT : float = 0.1

var can_shoot : bool
var speed : int
var screen_size : Vector2

signal shoot

func _ready():
	screen_size = get_viewport_rect().size
	reset()
	
func reset():
	position = screen_size / 2
	speed = START_SPEED
	$Timer.wait_time = NORMAL_SHOT
	can_shoot = true

func get_input():
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir.normalized() * speed
	
	#Mouse input
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_shoot:
		var dir = get_global_mouse_position() - position
		shoot.emit(position, dir)
		can_shoot = false
		$Timer.start()
		
func _on_timer_timeout():
	can_shoot = true
	
func boost():
	$BoostTimer.start()
	speed = BOOST_SPEED
	
func _on_boost_timer_timeout():
	speed = START_SPEED
	
func quick_fire():
	$FastFireTimer.start()
	$Timer.wait_time = FAST_SHOT

func _on_fast_fire_timer_timeout():
	$Timer.wait_time = NORMAL_SHOT

func _physics_process(_delta):
	#player movement
	get_input()
	move_and_slide()
	
	#limit movement to window size
	position = position.clamp(Vector2.ZERO, screen_size)
	
	#player rotation
	var mouse = get_local_mouse_position()
	var angle = snappedf(mouse.angle(), PI / 4) / (PI / 4)
	angle = wrap(int(angle), 0, 8)
	
	$AnimatedSprite2D.animation = "walk" + str(angle)
	
	#player animation
	if velocity.length() != 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.frame = 1
