extends AnimatableBody2D

const MAX_SPEED = 3000.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Vector2.UP.rotated(rotation)
	position += direction * MAX_SPEED * delta

func _on_collision_detection_body_entered(body):
	if body.is_in_group("player"):
		#print("Hit NPC!")
		queue_free()
	elif body.is_in_group("wall"):
		#print("Hit wall!")
		queue_free()
