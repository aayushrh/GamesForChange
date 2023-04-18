extends Buildings
var popup = preload("res://Building/PopupText.tscn")

func _ready():
	shape = RectangleShape2D.new()
	shape.extents = GameConstants.algaeFarmExtents
	sell_money = GameConstants.sellAlgaeFarm
	pollution = -30.0/60.0*GameConstants.turnTime
	money = 40_000.0/60.0*GameConstants.turnTime
	energy = -5.0/60.0*GameConstants.turnTime
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
#	var text = popup.instance()
#	add_child(text)
#	text.set_position(position)
#	text.set_text("+$")# + money + "")
	$Timer.start(GameConstants.turnTime)
