extends Label

var cookies = 0
var multi = 1 
var cost = 10


func _on_Button_pressed():
	cookies += multi

func _process(delta):
	text = str(cookies)

func _on_Button2_pressed():
	$Popup.show()
	get_tree().paused = true

func _on_multi_pressed():
	if cookies > cost:
		cookies -= cost
		cost += 10
		multi += 1

func _on_close_pressed():
	$Popup.hide()
	get_tree().paused = false
