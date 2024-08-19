extends "res://3D/player/statemachine/state.gd"


func update(delta):
	player_rotation()
	if player.input_dir != Vector2.ZERO:
		return states.walk
	if !player.is_on_floor():
		return states.fall
	if Input.is_action_just_pressed("jump"):
		return states.jump
	if Input.is_action_pressed("crawl"):
		return states.crawl


func enter_state():
	player.velocity = Vector3.ZERO
	player.play_animation("idle")


func exit_state():
	pass
