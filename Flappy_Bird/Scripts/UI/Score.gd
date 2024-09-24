extends Control

@onready var score = $Score
@onready var pause = $pause_button

func _process(delta):
	score.text = str(Global.points)
	
	if Global.game_over == true || Global.player_ready == true:
		pause.visible = false
		score.visible = false
	elif Global.playing == true:
		pause.visible = true
		score.visible = true
		
	if Global.player_ready == true:
		Global.points = 0
