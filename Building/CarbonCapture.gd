extends Buildings

func _ready():
	shape = RectangleShape2D.new()
	shape.extents = GameConstants.carbonCaptureExtents
	sell_money = GameConstants.sellCarbonCapture
	pollution = -2_000.0/60.0
	money = -150_000.0/60.0
	energy = -200.0/60.0
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
