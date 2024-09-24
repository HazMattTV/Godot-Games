extends Area2D

var pipes = preload("res://Objects/pipes.tscn")

@export_category("COORDINATES")
@export var x:int
@export var y1:int
@export var y2:int

func pipe_reset():
	var pipe_instance = pipes.instantiate()
	pipe_instance.position = Vector2(x,randi_range(y1,y2))
	get_parent().call_deferred("add_child", pipe_instance)

func _on_body_entered(body):
	if body.is_in_group("pipes"):
		body.queue_free()
		pipe_reset()
