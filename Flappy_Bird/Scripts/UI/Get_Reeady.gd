extends Control

func _process(delta):
	if Global.player_ready == false:
		visible = false
