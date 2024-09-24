extends Area2D

var base = preload("res://Objects/base.tscn")

@export_category("COORDINATES")
@export var x:int
@export var y:int

func base_reset():
	var base_instance = base.instantiate()
	base_instance.position = Vector2(x,y)
	get_parent().call_deferred("add_child", base_instance)

func _on_body_entered(body):
	if body.is_in_group("base"):
		body.queue_free()
		base_reset()
