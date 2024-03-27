extends CharacterBody2D

const BASE_SPEED : int = 300
const BASE_ATK : int = 1
const BASE_HEALTH : int = 3

var direction : Vector2
var screen_size : Vector2

func _ready():
	screen_size = get_viewport_rect().size
	position = screen_size/2
	
func get_input():
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir.normalized() * BASE_SPEED
	
	#Mouse input
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):# and can_shoot:
		#var dir = get_global_mouse_position() - position
		#shoot.emit(position, dir)
		#can_shoot = false
		$Timer.start()

func _physics_process(_delta):
	#player movement
	get_input()
	move_and_slide()
	
	#limit movement to window size
	#position = position.clamp((, 0), screen_size)
	
	#player rotation
	var mouse = get_local_mouse_position()
	var angle = snappedf(mouse.angle(), PI / 4) / (PI / 4)
	angle = wrap(int(angle), 0, 8)
	
	$AnimatedSprite2D.animation = "Walk_" + str(angle)
	
	#player animation
	if velocity.length() != 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.frame = 1
