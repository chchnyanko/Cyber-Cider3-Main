extends AnimatedSprite

var timer = 0
var text = 0

func _ready():
	frame = 0

func _process(delta): 
	timer += delta
	if frame == 97:
		get_tree().change_scene("res://scenes/menu/main_menu.tscn")
	if timer > 0.2:
		timer = 0
		text += 1
	if text == 4:
		text = 0
	if text == 0:
		$Label.text = ("Loading")
	if text == 1:
		$Label.text = ("Loading .")
	if text == 2:
		$Label.text = ("Loading . .")
	if text == 3:
		$Label.text = ("Loading . . .")
