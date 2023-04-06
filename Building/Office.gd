extends Buildings
class_name Office

var upgradeRad

func _ready():
	shape = RectangleShape2D.new()
	upgradeRad = GameConstants.upgradeRadOffice
	shape.extents = GameConstants.officeExtents
	sell_money = GameConstants.sellOffice
	pollution = 2.0/60.0
	money = 10_000.0/60.0
	energy = -50.0/60.0
	$Timer.start(GameConstants.turnTime)

func _process(delta):
	update()
	if selected:
		$Selection.visible = true
	else:
		$Selection.visible = false

func _draw():
	for i in affected:
		draw_line(Vector2.ZERO, i.global_position - global_position, Color(255, 255, 255), 3)

func _on_Timer_timeout():
	Manager.pollution += pollution
	Manager.money += money
	Manager.energy += energy
	$Timer.start(GameConstants.turnTime)
	
func _sell():
	for i in affected:
		i.energy /= 1.5
		i.pollution /= 1.5
		i.money /= 1.5
	._sell()
