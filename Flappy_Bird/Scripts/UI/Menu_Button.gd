extends TextureButton

func _on_pressed():
	await SceneTransition.change_scene("res://Scenes/Main_Menu.tscn")
	Global.game_over = false
	Global.start_menu = true
