extends Buildings

func _ready():
	shape = RectangleShape2D.new()
	shape.extents = GameConstants.ecoHotelExtents
	sell_money = GameConstants.sellEcoHotel
	pollution = -2
	money = 80_000
	energy = -5
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
