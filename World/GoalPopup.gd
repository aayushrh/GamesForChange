extends Node2D

var confetti_instance = preload("res://World//Confetti.tscn")
var time = 7
var count = 0.0
var text

onready var ee = $Box

# Called when the node enters the scene tree for the first time.
func _ready():
	$Box.text = text

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(get_position())
	count += delta
	if count > time:
		queue_free()
	pass

func confetti():
	var c = confetti_instance.instance()
	get_tree().current_scene.add_child(c)
