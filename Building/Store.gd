extends Buildings

func _ready():
	shape = RectangleShape2D.new()
	shape.extents = GameConstants.storeExtents
	sell_money = GameConstants.sellStore
	pollution = 2/60.0*GameConstants.turnTime
	money = 200_000/60.0*GameConstants.turnTime
	energy = -30/60.0*GameConstants.turnTime
	$Timer.start(GameConstants.turnTime)

func _process(delta):
	if selected:
		$Selection.visible = true
	else:
		$Selection.visible = false

func _on_Timer_timeout():
	if get_tree().get_root().get_node("World").energy >= 0:
		Manager.pollution += pollution
		Manager.money += money
		Manager.energy += energy
		var text = popup_scene.instance()
		text.money = money
		text.pollution = pollution
		text.set_position(global_position + label_offset)
		get_tree().current_scene.add_child(text)
		$Timer.start(GameConstants.turnTime)
