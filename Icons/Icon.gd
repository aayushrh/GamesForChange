extends TextureRect

signal pressed

export var icon = "";
export var cost = "";
export var pollution = "";
export var energy = "";
export var money = "";

func _ready():
	$HoverUI.get_rect().size = texture.get_size()
	$HoverUI/VBoxContainer/Name.text = icon
	$HoverUI/VBoxContainer/Cost.text = "Cost: " + cost
	$HoverUI/VBoxContainer/Pollution.text = "Pol: " + pollution
	$HoverUI/VBoxContainer/Energy.text = "Energy: " + energy
	$HoverUI/VBoxContainer/Money.text = "Money: " + money

func _on_Icon_gui_input(event):
	if event is InputEventMouseButton:
		emit_signal("pressed", icon)
