extends Label

var speed = 20
var friction = 0.8
var time = 1
var count = 0.0
#too lazy to put timer
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	count += delta
	if count >= time:
		queue_free()
	self.rect_position.y -= speed
	speed *= friction
	pass
