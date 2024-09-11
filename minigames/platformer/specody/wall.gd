extends "state.gd"

@export var slide_friction = 0.8

func update(delta):
	slide_movement(delta)
	if player.get_next_to_wall() == null:
		return states.fall
	if player.jump_input_actuation:
		if player.get_next_to_wall() == Vector2.LEFT:
			player.wall_jump_direction = 1
		elif player.get_next_to_wall() == Vector2.RIGHT:
			player.wall_jump_direction = -1
		if player.movement_input.x != 0:
			return states.walljump
	if player.dash_input and player.can_dash:
		return states.dash
	if player.is_on_floor():
		return states.idle
	return null

func slide_movement(delta):
	player_movement(delta)
	player.gravity(delta)
	player.velocity.y *= slide_friction

func enter_state():
	player.can_dash = true
	player.jumps = 0
