extends Buildings

func _ready():
	shape = RectangleShape2D.new()
	shape.extents = GameConstants.solarPowerPlantExtents
	sell_money = GameConstants.sellSolarPowerPlant
	pollution = 0
	money = -2_000
	energy = 100
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
