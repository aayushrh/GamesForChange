extends Buildings

func _ready():
	shape = RectangleShape2D.new()
	shape.extents = GameConstants.parkExtents
	sell_money = GameConstants.sellPark
	pollution = -4
	money = 1_000
	energy = 0
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
