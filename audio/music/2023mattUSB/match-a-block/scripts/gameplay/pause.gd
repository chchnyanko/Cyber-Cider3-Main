extends Popup

var thing = 0

func _process(delta):
	if Input.is_action_just_pressed("pause") and get_tree().paused == false:
		get_tree().paused = true
		show()
		thing = 1
	if Input.is_action_just_released("pause"):
		thing = 0
	if Input.is_action_just_pressed("pause") and get_tree().paused == true and thing == 0:
		hide()
		$options.not_show()
		get_tree().paused = false

func _on_Button_pressed():
	hide()
	get_tree().paused = false

func _on_Button2_pressed():
	hide()

func _on_Button3_pressed():
	show()

func _on_Button4_pressed():
	get_tree().paused = false
	hide()
	brain.position.x = 80
	brain.position.y = 80
	get_tree().change_scene("res://scenes/menu/main_menu.tscn")
