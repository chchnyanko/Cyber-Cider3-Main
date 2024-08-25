extends "res://3D/player/statemachine/state.gd"


@onready var timer: Timer = $Timer

var cutscene_name: String


func update(delta):
	if cutscene_name == "death":
		if player.is_on_floor():
			player.play_animation("wakeup", true)


func enter_state():
	player.camera_move.emit(false)
	player.velocity = Vector3.ZERO
	if cutscene_name == "tutorial":
		player.play_animation("wakeup")
		timer.start(5)
		$tutorial.show()
		$tutorial.global_position = player.global_position + Vector3(0, 3, 0)
	if cutscene_name == "end":
		player.play_animation("wakeup", true)
		timer.start(5)
		$end.rotation = player.camera_3d.rotation
		$end.show()
		$end.global_position = player.global_position + Vector3(0, 3, 0)
	if cutscene_name.contains("unlock"):
		var unlock = cutscene_name.replace("unlock", "")
		unlocks.set(unlock, true)
		timer.start(3)
		$unlock.show()
		$unlock.global_position = player.global_position + Vector3(0, 2, 0)
		$unlock.rotation = player.camera_3d.rotation
		if unlock == "dive":
			$unlock.text = "Unlocked dive
			Press Shift mid-air to perform a dive to get past large gaps"
		if unlock == "crawl":
			$unlock.text = "Unlocked crawl
			Press Shift on the ground to crawl and get in small gaps under buildings"
		if unlock == "climb":
			$unlock.text = "Unlocked climb
			Jump onto a wall to climb it"



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
	if cutscene_name == "end":
		get_tree().change_scene_to_file("res://ui menu/title.tscn")
	if cutscene_name.contains("unlock"):
		$unlock.hide()
		player.change_state(states.idle)
