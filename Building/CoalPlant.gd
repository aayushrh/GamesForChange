extends Buildings

func _ready():
	shape = RectangleShape2D.new()
	shape.extents = GameConstants.coalPlantExtents
	sell_money = GameConstants.sellCoalPlant
	pollution = 4_000.0/60.0*GameConstants.turnTime
	money = -20_000.0/60.0*GameConstants.turnTime
	energy = 500.0/60.0*GameConstants.turnTime
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
	$Timer.start(GameConstants.turnTime)
