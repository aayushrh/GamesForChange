extends Buildings

func _ready():
	shape = RectangleShape2D.new()
	shape.extents = GameConstants.storeExtents
	sell_money = GameConstants.sellStore
	pollution = 2
	money = 200_000
	energy = -30
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
