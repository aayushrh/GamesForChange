extends Control

func _ready():
	$Timer.start(GameConstants.turnTime)

func _process(delta):
	if(Manager.money >= 1000000):
		$Money/Label.text = str(round(Manager.money/1000000)) + " M"
	elif(Manager.money >= 1000):
		$Money/Label.text = str(round(Manager.money/1000)) + " K"
	else:
		$Money/Label.text = str(Manager.money)

func _on_Timer_timeout():
	$Timer.start(GameConstants.turnTime)
	$Pollution/Pollution.text = str(Manager.pollution)
	$Energy/Energy.text = str(Manager.energy)
