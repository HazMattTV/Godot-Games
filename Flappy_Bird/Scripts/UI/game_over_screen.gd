extends Control

@onready var scoreLabel = $Score
@onready var best_scoreLabel = $BestScore
@onready var medal = $Medal

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# If Global.game_over is true, make it visible; if not, don't.
	if Global.game_over == true:
		visible = true
	else:
		visible = false
	
	# Set the label's text to what Global points and best_score number is
	scoreLabel.text = str(Global.points)
	best_scoreLabel.text = str(Global.best_score)
	
	# Medal Colors
	if Global.points < 10:
		medal.modulate = Color(1,1,1,0) # None
	elif 10 <= Global.points and Global.points < 20:
		medal.modulate = Color(0.83,0.488,0.216,1) # Bronze
	elif 20 <= Global.points and Global.points < 40:
		medal.modulate = Color(0.84,0.824,0.803,1) # Silver
	elif 40 <= Global.points and Global.points < 75:
		medal.modulate = Color(0.881,0.852,0.231,1) # Gold
	elif 75 <= Global.points and Global.points < 120:
		medal.modulate = Color(1,1,1,1) # Platinum
	elif 120 <= Global.points and Global.points < 160:
		medal.modulate = Color(0.273, 0.943, 0.978, 1) # Diamond
	elif 160 <= Global.points and Global.points < 200:
		medal.modulate = Color(0.135,0.981,0,1) # Emerald
	elif 200 <= Global.points:
		medal.modulate = Color(1,0.144,0.163,1) # Ruby
