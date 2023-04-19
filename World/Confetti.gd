extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var vel = Vector2.ZERO
var gravity = 5
var friction = 0.95



# Called when the node enters the scene tree for the first time.
func _ready():
	self.rect.position.x = randi() % 200 - 100
	vel = Vector2(randi() % 100 - 50, randi() % 20)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	vel.y += gravity
	self.rect.position += vel
	vel *= friction
	pass
