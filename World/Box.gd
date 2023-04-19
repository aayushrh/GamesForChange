extends Node2D

var velocity = 0
var target = 50
var speed = 0.005
var friction = 0.95
var time = 5
var count = 0
var text = ""

# Called when the node enters the scene tree for the first time.
func ready():
	#print(text)
	set_position(Vector2(0, -50))
	get_node("Label").set_text(text)
	get_node("Label").set_position(-get_node("Label").get_size()/2)
	get_node("Label").set_position(-get_node("Label").get_size()/2)
	get_node("ColorRect").set_size(Vector2(get_node("Label").get_size().x + 10, 30))
	get_node("ColorRect").set_position(-get_node("ColorRect").get_size()/2)
	get_node("ColorRect2").set_size(Vector2(get_node("Label").get_size().x + 16, 36))
	get_node("ColorRect2").set_position(-get_node("ColorRect2").get_size()/2)
	
	#print(get_node("Label").get_size())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	count += delta
	if count > time:
		target = -100
	velocity += (target - get_position().y) * speed
	velocity *= friction
	set_position(Vector2(get_position().x, get_position().y + velocity))
	#print(get_global_position())
	pass
