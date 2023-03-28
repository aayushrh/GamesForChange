extends Buildings

func _ready():
	shape = RectangleShape2D.new()
	shape.extents = GameConstants.nuclearPlantExtents
	sell_money = GameConstants.sellNuclearPlant
	pollution = 0
	money = 1_500_000.0/60.0
	energy = 10_000.0/60.0
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
