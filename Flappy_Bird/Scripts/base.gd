extends AnimatableBody2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.game_over == false:
		position += Vector2(-4,0)
