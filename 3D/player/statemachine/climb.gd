extends "res://3D/player/statemachine/state.gd"


func update(delta):
	player_rotation()
	climb()
	
	if !player.is_on_wall() or Input.is_action_just_pressed("crawl") or player.is_on_floor():
		return states.idle
	if Input.is_action_just_pressed("jump"):
		return states.climb_jump


func enter_state():
	player.play_animation("wall")


func exit_state():
	pass
