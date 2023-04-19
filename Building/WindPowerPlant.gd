extends Buildings

func _ready():
	shape = RectangleShape2D.new()
	shape.extents = GameConstants.windPlantExtents
	sell_money = GameConstants.sellWindPlant
	pollution = 0
	money = -600.0/60.0*GameConstants.turnTime
	energy = 20.0/60.0*GameConstants.turnTime
	$Timer.start(GameConstants.turnTime)

func _process(delta):
	if selected:
		$Selection.visible = true
	else:
		$Selection.visible = false

func _on_Timer_timeout():
	Manager.pollution += pollution
	Manager.money += money
	Manager.energy += energy
	var text = popup_scene.instance()
	text.money = money
	text.pollution = pollution
	text.set_position(global_position + label_offset)
	get_tree().current_scene.add_child(text)
	$Timer.start(GameConstants.turnTime)
