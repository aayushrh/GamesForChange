extends Node2D

var first_goal = false
var sec_goal = false
var third_goal = false
var goal_popup_instance = preload("res://World//GoalPopup.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_position(Vector2(160, 0))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var world = get_tree().get_root().get_node("World")
	if world.pollution <= 0 and Manager.money >= 5000000 and world.energy > 0 and not first_goal:
		first_goal = true
		make_popup("Congrats! You passed the first milestone!")
	if world.pollution <= -10 and Manager.money >= 10000000 and world.energy > 100 and not sec_goal:
		sec_goal = true
		make_popup("Congrats! You passed the second milestone!")
	if world.pollution <= -10000 and Manager.money >= 100000000 and world.energy > 10000  and Manager.pollution <= -20000 and not sec_goal:
		sec_goal = true
		make_popup("Congrats! You passed the third and last milestone!")
	pass

func make_popup(msg):
	var popup = goal_popup_instance.instance()
	add_child(popup)
	popup.set_position(get_position())
	popup.ee.text = msg
	popup.ee.ready()
