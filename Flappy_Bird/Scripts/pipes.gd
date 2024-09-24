extends AnimatableBody2D

@onready var point = $SFX/Point

func _physics_process(delta):
	if Global.game_over == false and Global.player_ready == false:
		position += Vector2(-2,0)


func _on_area_2d_body_entered(body):
	Global.points += 1
	point.play()
