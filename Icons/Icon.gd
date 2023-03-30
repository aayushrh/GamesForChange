extends TextureRect

signal pressed

export var icon = "";
export var money = 0
export var pollution = 0
export var energy = 0

func _ready():
	$HoverUI.get_rect().size = texture.get_size()
	$HoverUI/VBoxContainer/Name.text = icon
	$HoverUI/VBoxContainer/Cost.text = "$" + money as String
	$HoverUI/VBoxContainer/Pollution.text = pollution as String + " Pol"
	$HoverUI/VBoxContainer/Energy.text = energy as String + " kW"

func _on_Icon_gui_input(event):
	if event is InputEventMouseButton:
		emit_signal("pressed", icon)
