extends "res://3D/player/statemachine/state.gd"


@onready var timer: Timer = $Timer

var cutscene_name: String


func update(delta):
	if cutscene_name == "death":
		if player.is_on_floor():
			player.play_animation("death")


func enter_state():
	player.camera_move.emit(false)
	player.velocity = Vector3.ZERO
	if cutscene_name == "tutorial":
		player.play_animation("wakeup")
		timer.start(5)
		$tutorial.show()
		$tutorial.global_position = player.global_position + Vector3(0, 3, 0)


func exit_state():
	cutscene_name = ""
	player.camera_move.emit(true)


func _on_yarts_player_death() -> void:
	cutscene_name = "death"


func _on_animated_sprite_2d_animation_finished() -> void:
	if cutscene_name == "":
		return
	elif cutscene_name == "death":
		get_tree().change_scene_to_file("res://3D/city.tscn")


func _on_timer_timeout() -> void:
	if cutscene_name == "tutorial":
		$tutorial.hide()
		player.change_state(states.idle)
