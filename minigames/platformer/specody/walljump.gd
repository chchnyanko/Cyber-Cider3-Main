extends "state.gd"

@onready var walljumptimer = $walljumptime
var walljumptime = 0.3
var walljumping = true
var crazywalljump = false

func update(_delta):
	player.velocity.x = player.max_speed * player.wall_jump_direction
	if crazywalljump:
		player.velocity.x *= 5
		if walljumptimer.time_left < 9.5 and player.is_on_wall():
			return states.fall
	if !walljumping or Input.is_action_just_released("up"):
		return states.fall
	if player.dash_input and player.can_dash:
		return states.dash
	return null

func enter_state():
	if player.movement_input.x == 0:
		walljumptime = 10
		crazywalljump = true
	else:
		walljumptime = 0.3
		crazywalljump = false
	walljumping = true
	walljumptimer.start(walljumptime)
	player.velocity.y = player.jump_velocity

func _on_walljumptime_timeout():
	walljumping = false
