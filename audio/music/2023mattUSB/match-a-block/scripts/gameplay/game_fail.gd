extends Popup

func _process(delta):
	if brain.state == 1:
		show()
		get_tree().paused = true


func _on_Button_pressed():
	hide()
	get_tree().paused = false
