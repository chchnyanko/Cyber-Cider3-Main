extends Area2D

func _on_play_game_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			brain.reset()
			get_tree().change_scene("res://scenes/gameplay/brain.tscn")


func _on_play_game_mouse_entered():
	$Sprite.play('anim')


func _on_play_game_mouse_exited():
	$Sprite.play("default")
