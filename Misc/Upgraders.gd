extends Line2D

export(int) var numPoints = 30
export(int) var radius = 0

var lifetime = 1

func _ready():
	var new_points = []
	for i in range(numPoints):
		var new_point = Vector2(radius * cos((2.5*PI/(numPoints)*i)), radius * sin((2.5*PI/(numPoints))*i))
		new_points.append(new_point)
	points = new_points

func _process(delta):
	if lifetime <= 0:
		queue_free()
	lifetime -= 1
