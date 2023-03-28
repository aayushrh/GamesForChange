extends Node2D

var lifetime = 1

func _process(delta):
	if lifetime <= 0:
		queue_free()
	lifetime -= 1
