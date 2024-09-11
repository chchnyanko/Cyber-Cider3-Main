extends "res://3D/player/statemachine/state.gd"


const speed: float = 15


func update(delta):
	player_rotation()
	player_movement(speed)
	
	if !player.is_on_floor():
		return states.fall
	if Input.is_action_just_pressed("jump"):
		return states.jump
	if player.input_dir == Vector2.ZERO:
		return states.idle
	if Input.is_action_pressed("crawl"):
		return states.crawl


func enter_state():
	player.play_animation("walk")


func exit_state():
	player.velocity = Vector3.ZERO
