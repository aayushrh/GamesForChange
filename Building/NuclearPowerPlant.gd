extends Buildings

func _ready():
	shape = RectangleShape2D.new()
	shape.extents = GameConstants.nuclearPlantExtents
	sell_money = GameConstants.sellNuclearPlant
	pollution = 0*GameConstants.turnTime
	money = 1_500_000.0/60.0*GameConstants.turnTime
	energy = 10_000.0/60.0*GameConstants.turnTime
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
	text.set_position(global_position)
	text.set_position(global_position + label_offset)
	$Timer.start(GameConstants.turnTime)
