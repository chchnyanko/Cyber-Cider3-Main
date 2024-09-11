extends "state.gd"

func update(delta):
	player.gravity(delta)
	if player.movement_input.x != 0:
		return states.move
	if player.jump_input_actuation:
		return states.jump
	if player.velocity.y > 0:
		return states.fall
	if player.dash_input and player.can_dash:
		return states.dash
	return null

func enter_state():
	player.jumps = 0
	player.can_dash = true
