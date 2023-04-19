extends Label

var speed = 10
var friction = 0.8
var time = 1
var count = 0.0
var money 
var pollution 

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func abbreviate(number):
	var moneystr = ""
	if(abs(number) >= 1000000):
		moneystr = str(round(abs(number)/100000)/10.0) + " M"
	elif(abs(number) >= 1000):
		moneystr = str(round(abs(number)/100)/10.0) + " K"
	else:
		moneystr = str(round(abs(number)*10)/10.0)
	return(moneystr)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	var txt = ""
	if money < 0:
		txt += "-"
	else:
		txt += "+"
	txt += "$" + abbreviate(money) + "\n"
	if pollution < 0:
		txt += "-"
	else:
		txt += "+"
	txt += abbreviate(pollution) + " T CO2"
	set_text(txt)
	set_size(Vector2(100, 100))
	pass # Replace with function body.

func _process(delta):
	#print("working")
	count += delta
	#print(str(count) + "e")
	#print("snt")
	if count >= time:
		#print("ded")
		queue_free()
	self.rect_position.y -= speed
	speed *= friction
	pass
