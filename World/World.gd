extends Node2D

var dragging = false
var selected = []
var buildings = []
var upgraders = []
var drag_start = Vector2.ZERO
var select_rect = RectangleShape2D.new()
var can_spawn = true
var pollutionReq = 0
var energyReq = 0
var pollutionDelta = 0
var energyDelta = 0

onready var CoalPlant = preload("res://Building//CoalPlant.tscn")
onready var Office = preload("res://Building//Office.tscn")
onready var Park = preload("res://Building//Park.tscn")
onready var Store = preload("res://Building//Store.tscn")
onready var SolarPowerPlant = preload("res://Building//SolarPowerPlant.tscn")
onready var WindPowerPlant = preload("res://Building//WindPowerPlant.tscn")
onready var AlgaeFarm = preload("res://Building//AlgaeFarm.tscn")
onready var NuclearPlant = preload("res://Building//NuclearPowerPlant.tscn")
onready var CarbonCapture = preload("res://Building//CarbonCapture.tscn")
onready var Factory = preload("res://Building//Factory.tscn")
onready var Hotel = preload("res://Building//Hotel.tscn")
onready var Green_Box = preload("res://Misc//Green_Box.tscn")
onready var Red_Box = preload("res://Misc//Red_Box.tscn")
onready var Upgraders = preload("res://Misc//Upgraders.tscn")

func _unhandled_input(event):
	_draw()
	if Manager.mode == "Selection":
		if selected.size() != 0:
			Manager.selecting = true
		if event is InputEventScreenTouch:
			if event.pressed:
				if selected.size() == 0:
					dragging = true
					drag_start = get_global_mouse_position()
			elif dragging:
				dragging = false
				update()
				var drag_end = get_global_mouse_position()
				selected = check(drag_start, drag_end)
				for item in selected:
					item.collider.selected = true
		if event is InputEventScreenDrag and dragging:
			update()
	elif Manager.mode != "Move":
		if event is InputEventScreenTouch and can_spawn:
			var mouse_pos = get_global_mouse_position()
			var pos = Vector2(fround(mouse_pos.x), fround(mouse_pos.y))
			var building = _getBuilding()
			var buildingPoly = _getBuildingPoly()
			building._ready()
			building.global_position = pos
			if(fmod(buildingPoly.extents.x + 1, 16) == 0):
				building.global_position = building.global_position - Vector2(8, 0)
			if(fmod(buildingPoly.extents.y + 1, 16) == 0):
				building.global_position = building.global_position - Vector2(0, 8)
			for i in buildings:
				if(checkColl(buildingPoly, i, building)):
					can_spawn = false
			if can_spawn:
				can_spawn = _moneyCheck()
				if(can_spawn):
					can_spawn = false
					$YSort.add_child(building)
					if(Manager.mode == "Office"):
						for i in buildings:
							if(i.global_position.distance_to(building.global_position) <= GameConstants.upgradeRadOffice):
								i.money *= 1.5
								i.pollution *= 1.5
								i.energy *= 1.5
								building.affected.append(i)
						upgraders.append(building)
					else:
						for i in upgraders:
							if(i.global_position.distance_to(building.global_position) <= i.upgradeRad):
								building.money *= 1.5
								building.pollution *= 1.5
								building.energy *= 1.5
								i.affected.append(building)
					buildings.append(building)
					Manager.mode = "Selection"
			$Spawn_Timer.start(1)
		if dragging:
			update()

func _process(delta):
	var pollution = 0
	var money = 0
	var energy = 0
	for b in buildings :
		pollution += b.pollution
		money += b.money
		energy += b.energy
	pollutionDelta = pollution
	energyDelta = energy
	
	pollutionDelta = round(pollutionDelta * 100)/100
	
	if(Input.is_action_just_pressed("cancel")):
		Manager.mode = "Selection"
	if(pollution > 0):
		$CanvasLayer/UI/PollutionDelta/PollutionDelta.text = "+" + str(pollution)
	else:
		$CanvasLayer/UI/PollutionDelta/PollutionDelta.text = str(pollution)
	
	money = round(money * 100)/100
	
	var moneystr = ""
	if(abs(money) >= 1000000):
		moneystr = str(round(money/1000000)) + " M"
	elif(abs(money) >= 1000):
		moneystr = str(round(money/1000)) + " K"
	else:
		moneystr = str(money)
	
	if(money > 0):
		$CanvasLayer/UI/MoneyDelta/Label.text = "+" + moneystr
	else:
		$CanvasLayer/UI/MoneyDelta/Label.text = moneystr
	
	energy = round(energy * 100)/100
	
	if(energy > 0):
		$CanvasLayer/UI/EnergyDelta/EnergyDelta.text = "+" + str(energy)
	else:
		$CanvasLayer/UI/EnergyDelta/EnergyDelta.text = str(energy)
	update()
	if(Input.is_action_just_pressed("sell")):
		_on_Sell_pressed()
	
func _moneyCheck():
	var can_spawnn = true
	if (Manager.mode == "CoalPlant"):
		if(Manager.money >= GameConstants.costCoalPlant):
			Manager.money -= GameConstants.costCoalPlant
		else:
			can_spawnn = false
	elif (Manager.mode == "Office"):
		if(Manager.money >= GameConstants.costOffice):
			Manager.money -= GameConstants.costOffice
		else:
			can_spawnn = false
	elif (Manager.mode == "Park"):
		if(Manager.money >= GameConstants.costPark):
			Manager.money -= GameConstants.costPark
		else:
			can_spawnn = false
	elif (Manager.mode == "Store"):
		if(Manager.money >= GameConstants.costStore):
			Manager.money -= GameConstants.costStore
		else:
			can_spawnn = false
	elif (Manager.mode == "SolarPowerPlant"):
		if(Manager.money >= GameConstants.costSolarPowerPlant):
			Manager.money -= GameConstants.costSolarPowerPlant
		else:
			can_spawnn = false
	elif (Manager.mode == "WindPowerPlant"):
		if(Manager.money >= GameConstants.costWindPlant):
			Manager.money -= GameConstants.costWindPlant
		else:
			can_spawnn = false
	elif (Manager.mode == "AlgaeFarm"):
		if(Manager.money >= GameConstants.costAlgaeFarm):
			Manager.money -= GameConstants.costAlgaeFarm
		else:
			can_spawnn = false
	elif (Manager.mode == "NuclearPowerPlant"):
		if(Manager.money >= GameConstants.costNuclearPlant):
			Manager.money -= GameConstants.costNuclearPlant
		else:
			can_spawnn = false
	elif (Manager.mode == "CarbonCapture"):
		if(Manager.money >= GameConstants.costCarbonCapture):
			Manager.money -= GameConstants.costCarbonCapture
		else:
			can_spawnn = false
	elif (Manager.mode == "Factory"):
		if(Manager.money >= GameConstants.costFactory):
			Manager.money -= GameConstants.costFactory
		else:
			can_spawnn = false
	elif (Manager.mode == "Hotel"):
		if(Manager.money >= GameConstants.costEcoHotel):
			Manager.money -= GameConstants.costEcoHotel
		else:
			can_spawnn = false
	return can_spawnn

func checkColl(build, coll, pos):
	var val =  build.collide(pos.transform, coll.shape, coll.transform)
	return val

func check(start, end):
	select_rect.extents = (end - start)/2
	var space = get_world_2d().direct_space_state
	var query = Physics2DShapeQueryParameters.new()
	query.set_shape(select_rect)
	query.transform = Transform2D(0, (end + start)/2)
	selected = space.intersect_shape(query)
	var new_selected = []
	for i in range(0, selected.size()):
		new_selected.append(selected[i])
	selected = new_selected
	return selected

func _getBuilding():
	var building = null
	if(Manager.mode == "CoalPlant"):
		building = CoalPlant.instance()
	elif(Manager.mode == "Office"):
		building = Office.instance()
	elif(Manager.mode == "Park"):
		building = Park.instance()
	elif(Manager.mode == "Store"):
		building = Store.instance()
	elif(Manager.mode == "SolarPowerPlant"):
		building = SolarPowerPlant.instance()
	elif(Manager.mode == "WindPowerPlant"):
		building = WindPowerPlant.instance()
	elif(Manager.mode == "AlgaeFarm"):
		building = AlgaeFarm.instance()
	elif(Manager.mode == "NuclearPowerPlant"):
		building = NuclearPlant.instance()
	elif(Manager.mode == "CarbonCapture"):
		building = CarbonCapture.instance()
	elif(Manager.mode == "Factory"):
		building = Factory.instance()
	elif(Manager.mode == "Hotel"):
		building = Hotel.instance()
	return building

func _getBuildingPoly():
	var buildingPoly = RectangleShape2D.new()
	if(Manager.mode == "CoalPlant"):
		buildingPoly.extents = GameConstants.coalPlantExtents
	elif(Manager.mode == "Office"):
		buildingPoly.extents = GameConstants.officeExtents
	elif(Manager.mode == "Park"):
		buildingPoly.extents = GameConstants.parkExtents
	elif(Manager.mode == "Store"):
		buildingPoly.extents = GameConstants.storeExtents
	elif(Manager.mode == "SolarPowerPlant"):
		buildingPoly.extents = GameConstants.solarPowerPlantExtents
	elif(Manager.mode == "WindPowerPlant"):
		buildingPoly.extents = GameConstants.windPlantExtents
	elif(Manager.mode == "AlgaeFarm"):
		buildingPoly.extents = GameConstants.algaeFarmExtents
	elif(Manager.mode == "NuclearPowerPlant"):
		buildingPoly.extents = GameConstants.nuclearPlantExtents
	elif(Manager.mode == "CarbonCapture"):
		buildingPoly.extents = GameConstants.carbonCaptureExtents
	elif(Manager.mode == "Factory"):
		buildingPoly.extents = GameConstants.factoryExtents
	elif(Manager.mode == "Hotel"):
		buildingPoly.extents = GameConstants.ecoHotelExtents
	return buildingPoly

func fround(num):
	if (fmod(num, 16) < 8):
		 return num - fmod(num, 16)
	else:
		return num + (16 - fmod(num, 16))

func _draw():
	if dragging:
		if Manager.mode == "Selection":
			draw_rect(Rect2(drag_start, get_global_mouse_position() - drag_start), Color(0, 0, 0.5), false)
	if Manager.mode != "Selection" && Manager.mode != "Move":
			var mouse_pos = get_global_mouse_position()
			var pos = Vector2(fround(mouse_pos.x), fround(mouse_pos.y))
			var building = _getBuilding()
			var buildingPoly = _getBuildingPoly()
			if(fmod(buildingPoly.extents.x + 1, 16) == 0):
				pos = pos - Vector2(8, 0)
			if(fmod(buildingPoly.extents.y + 1, 16) == 0):
				pos = pos - Vector2(0, 8)
			building.global_position = pos
			var nothing = true
			for i in buildings:
				if(checkColl(buildingPoly, i, building)):
					nothing = false
			var box
			if nothing:
				box = Green_Box.instance()
			else:
				box = Red_Box.instance()
			box.global_position = building.global_position
			if Manager.mode == "CoalPlant":
				box.scale.x = 3
				box.scale.y = 2
			elif Manager.mode == "Office":
				box.scale.x = 2
				box.scale.y = 2
				var upgrader = Upgraders.instance()
				upgrader.global_position = box.global_position
				upgrader.radius = GameConstants.upgradeRadOffice
				self.add_child(upgrader)
			elif Manager.mode == "Park":
				box.scale.x = 3
				box.scale.y = 3
			elif Manager.mode == "Store":
				box.scale.x = 2
				box.scale.y = 2
			elif Manager.mode == "SolarPowerPlant":
				box.scale.x = 6
				box.scale.y = 5
			elif Manager.mode == "WindPowerPlant":
				box.scale.x = 4
				box.scale.y = 2
			elif Manager.mode == "AlgaeFarm":
				box.scale.x = 6
				box.scale.y = 5
			elif Manager.mode == "NuclearPowerPlant":
				box.scale.x = 8
				box.scale.y = 6
			elif Manager.mode == "Factory":
				box.scale.x = 4
				box.scale.y = 4
			elif Manager.mode == "Hotel":
				box.scale.x = 2
				box.scale.y = 2
			elif Manager.mode == "CarbonCapture":
				box.scale.x = 2
				box.scale.y = 2
			self.add_child(box)

func _on_Sell_pressed():
	if Manager.selecting:
		for item in selected:
			item.collider._sell()
		Manager.selecting = false
		dragging = false
		selected = []

func _hideAll():
	$CanvasLayer/UI/UICenter/PollutorsIcons.visible = false
	$CanvasLayer/UI/UICenter/UpgradersIcons.visible = false
	$CanvasLayer/UI/UICenter/NonPollutorsIcons.visible = false

func _on_Office_pressed():
	Manager.mode = "Office"

func _on_CoalPlant_pressed():
	Manager.mode = "CoalPlant"

func _on_Park2_pressed():
	Manager.mode = "Park"

func _on_Store_pressed():
	Manager.mode = "Store"

func _on_SolarPowerPlant_pressed():
	Manager.mode = "SolarPowerPlant"

func _on_QuotaTimer_timeout():
	$QuotaTimer.start(GameConstants.quotaTime)
	if(pollutionDelta > pollutionReq or energyDelta < energyReq):
		SceneChanger.change_scene_to(load("res://World/StartingScreen.tscn"))
		Manager.money = 5_000_000
		Manager.pollution = 0
		Manager.energy = 0
	else:
		Manager.money += -pollutionReq*100
	if(pollutionReq > 0):
		pollutionReq *= 1.2
		energyReq *= 1.1
	else:
		pollutionReq = -20
		energyReq = 20
	$CanvasLayer/Quota.visible = true
	$CanvasLayer/Quota/Energy.text = ("After 2 minute you need to be gaining " + str(energyReq) + " energy")
	$CanvasLayer/Quota/Pollution.text = "And also losing polltion by " + str(-pollutionReq) + " per turn"

func _on_Spawn_Timer_timeout():
	can_spawn = true

func _on_NonPollutors2_pressed():
	_hideAll()
	$CanvasLayer/UI/UICenter/NonPollutorsIcons.visible = true

func _on_Pollutors_pressed():
	_hideAll()
	$CanvasLayer/UI/UICenter/PollutorsIcons.visible = true

func _on_Upgrader_pressed():
	_hideAll()
	$CanvasLayer/UI/UICenter/UpgradersIcons.visible = true

func _on_Factory2_pressed():
	Manager.mode = "Factory"

func _on_Nuclear_pressed():
	Manager.mode = "NuclearPowerPlant"

func _on_Algae_pressed():
	Manager.mode = "AlgaeFarm"

func _on_CarbonCapture_pressed():
	Manager.mode = "CarbonCapture"

func _on_TouchScreenButton_pressed():
	Manager.mode = "Hotel"

func _on_Wind_pressed():
	Manager.mode = "WindPowerPlant"
