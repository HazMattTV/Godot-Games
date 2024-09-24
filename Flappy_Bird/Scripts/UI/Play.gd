extends TextureButton

func _on_pressed():
	await SceneTransition.change_scene("res://Scenes/Gameplay__Scene.tscn")
	Global.start_menu = false
	Global.player_ready = true
	
