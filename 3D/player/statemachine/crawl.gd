extends "res://3D/player/statemachine/state.gd"


@onready var collision: CollisionShape3D = $"../../CollisionShape3D"

const speed: float = 8


func update(delta):
	player_movement(speed)
	player_gravity(delta)
	player_rotation()
	
	if !Input.is_action_pressed("crawl") and check_ceiling() == false:
		return states.idle


func enter_state():
	player.play_animation("dash")
	collision.scale.y = 0.5


func exit_state():
	collision.scale.y = 1
