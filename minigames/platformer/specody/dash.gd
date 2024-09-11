extends "state.gd"

var dash_direction = Vector2.ZERO
var dash_speed = 1200
var dashing = false
@export var dash_duration = 0.25
@onready var dash_duration_timer = $dashduration

func update(_delta):
	if !dashing:
		return states.fall
	return null

func enter_state():
	player.can_dash = false
	dashing = true
	dash_duration_timer.start(dash_duration)
	if player.movement_input.x != 0:
		dash_direction = player.movement_input
	else:
		dash_direction = player.last_direction
	if player.previous_state == states.wall:
		if player.get_next_to_wall() == Vector2.LEFT:
			dash_direction = Vector2.RIGHT
		elif player.get_next_to_wall() == Vector2.RIGHT:
			dash_direction = Vector2.LEFT
	player.velocity.x = dash_direction.x * dash_speed
	player.velocity.y = 0
	if dash_direction == Vector2.RIGHT:
		player.sprite.flip_h = false
	elif dash_direction == Vector2.LEFT:
		player.sprite.flip_h = true

func exit_state():
	player.velocity.x = 0
	dashing = false

func _on_dashduration_timeout():
	dashing = false
