extends "res://3D/player/statemachine/state.gd"


var cutscene_name: String


func update(delta):
	if cutscene_name == "death":
		if player.is_on_floor():
			player.play_animation("wakeup", true)


func enter_state():
	pass


func exit_state():
	cutscene_name = ""


func _on_yarts_player_death() -> void:
	cutscene_name = "death"


func _on_animated_sprite_3d_animation_finished() -> void:
	if cutscene_name == "":
		return
	elif cutscene_name == "death":
		get_tree().change_scene_to_file("res://3D/city.tscn")
