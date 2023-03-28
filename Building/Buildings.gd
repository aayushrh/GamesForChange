extends StaticBody2D
class_name Buildings

var selected = false
var selectable = true
var shape
var sold = false
var pollution = 0
var money = 0
var energy = 0
var affected = []

export(int) var sell_money

func _unhandled_input(event):
	if event is InputEventScreenTouch and selected:
		get_tree().current_scene.selected = []
		selected = false

func _sell():
	if !sold:
		Manager.money += sell_money
	sold = true
	get_tree().current_scene.buildings.remove(get_tree().current_scene.buildings.find(self))
	queue_free()

func _destroy():
	get_tree().current_scene.buildings.remove(get_tree().current_scene.buildings.find(self))
	queue_free()
