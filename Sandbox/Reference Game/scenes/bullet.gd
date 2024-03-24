extends Area2D

var speed : int = 500
var direction : Vector2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += speed * direction * delta

func _on_timer_timeout():
	queue_free()

func _on_body_entered(body):
	if body.name == "World":
		queue_free()
	elif body.name.substr(0, 6) == "Goblin":
		if body.alive:
			body.die()
			queue_free()
