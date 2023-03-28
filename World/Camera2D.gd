extends Camera2D

export (NodePath) var target

export(bool) var target_return_enabled = true
export(float) var target_return_rate = 0.02
export(float) var min_zoom = 0.5
export(float) var max_zoom = 2
export(float) var zoom_speed = 0.05
export(float) var zoom_sensitivity = 10 

var events = {}
var last_drag_distance = 0
var clicking = false

func _unhandled_input(event):
	if Manager.mode == "Move":
		if event is InputEventScreenTouch:
			if event.pressed:
				events[event.index] = event
			else:
				events.erase(event.index)
		if event is InputEventScreenDrag:
			events[event.index] = event
			if events.size() == 1:
				position -= event.relative * zoom.x 
			elif events.size() == 2:
				var drag_distance = events[0].position.distance_to(events[1].position)
				if abs(drag_distance - last_drag_distance) > zoom_sensitivity:
					var new_zoom = (1 + zoom_speed) if drag_distance < last_drag_distance else (1 - zoom_speed)
					new_zoom = clamp(zoom.x * new_zoom, min_zoom, max_zoom)
					zoom = Vector2.ONE * new_zoom
					last_drag_distance = drag_distance

func _process(delta):
	if(Input.is_action_just_pressed("right_click")):
		clicking = true
	elif (Input.is_action_just_released("right_click")):
		clicking = false
