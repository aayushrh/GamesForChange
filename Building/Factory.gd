extends Buildings

func _ready():
	shape = RectangleShape2D.new()
	shape.extents = GameConstants.factoryExtents
	sell_money = GameConstants.sellFactory
	pollution = 500.0/60.0
	money = 1_000_000.0/60.0
	energy = -450.0/60.0
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
