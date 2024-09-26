extends Area2D

var speed = 1


func _process(delta):
	if Input.is_action_pressed("action"):
		speed = 10
	else:
		speed = 1
	if $Label.rect_position.y > -2600:
		$Label.rect_position.y -= speed
	else:
		get_tree().change_scene("res://scenes/menu/main_menu.tscn")
