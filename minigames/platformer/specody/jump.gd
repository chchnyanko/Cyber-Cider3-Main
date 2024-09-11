extends "state.gd"

@onready var jumptimer = $jumpholdtimer
@export var jump_duration = 1

func update(delta):
	player.gravity(delta)
	player_movement(delta)
	if player.jump_input and jumptimer.time_left > 0:
		player.velocity.y *= 1.04
	else:
		jumptimer.stop()
	if player.velocity.y > 0:
		return states.fall
	if player.dash_input and player.can_dash:
		return states.dash
	if player.jump_input_actuation and player.jumps < 2:
		enter_state()
	return null

func enter_state():
	player.jump_input_actuation = false
	if player.previous_state == states.fall:
		player.jumps += 2
	else:
		player.jumps += 1
	jumptimer.start(jump_duration)
	player.velocity.y = player.jump_velocity
