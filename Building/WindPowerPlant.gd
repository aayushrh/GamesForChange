extends Buildings

func _ready():
	shape = RectangleShape2D.new()
	shape.extents = GameConstants.windPlantExtents
	sell_money = GameConstants.sellWindPlant
	pollution = 0
	money = -600
	energy = 20
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
