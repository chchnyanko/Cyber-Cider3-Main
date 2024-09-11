extends "state.gd"

@onready var coyotetimer = $coyotetime
@export var coyote_duration = 0.2
var can_jump = true

func update(delta):
	player.gravity(delta)
	player_movement(delta)
	if player.is_on_floor():
		return states.idle
	if player.dash_input and player.can_dash:
		return states.dash
	if player.get_next_to_wall() != null:
		return states.wall
	if player.jump_input_actuation and can_jump or player.jump_input_actuation and player.jumps < 2:
		return states.jump
	return null

func enter_state():
	if player.previous_state == states.idle or player.previous_state == states.move or player.previous_state == states.wall:
		can_jump = true
		coyotetimer.start(coyote_duration)
	else:
		can_jump = false

func _on_coyotetimer_timeout() -> void:
	can_jump = false
