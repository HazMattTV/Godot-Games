extends TextureButton


func _on_toggled(toggled_on):
	if toggled_on:
		get_tree().paused = true
	elif !toggled_on:
		get_tree().paused = false
