extends "state.gd"

func update(delta):
	player.gravity(delta)
	player_movement(delta)
	if player.velocity.x == 0:
		return states.idle
	if player.velocity.y > 0:
		return states.fall
	if player.jump_input_actuation:
		return states.jump
	if player.dash_input and player.can_dash:
		return states.dash
	return null

func enter_state():
	player.can_dash = true
