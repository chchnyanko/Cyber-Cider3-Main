extends Node

class_name state

## The states used for the players statemachine

const base_gravity: float = 35
const terminal_velocity: float = 80
const climb_speed: float = 5

var states: Node
var player: yarts
var ceiling_checker: ShapeCast3D
var wall_normal: Vector3
var stamina_bar: TextureProgressBar
var stamina: float

var gravity: float

func update(delta):
	pass

func enter_state() -> void:
	pass

func exit_state() -> void:
	pass

func player_gravity(delta: float) -> void:
	if player.velocity.y > 0:
		gravity = base_gravity * 2
	else:
		gravity = base_gravity
	if player.velocity.y > -terminal_velocity:
		player.velocity.y -= gravity * delta

func player_movement(speed: float) -> void:
	var vector = player.camera_3d.transform.basis.x * player.input_dir.x + player.camera_3d.transform.basis.z * player.input_dir.y
	var normalised = Vector2(vector.x, vector.z).normalized()
	player.velocity.x = normalised.x * speed
	player.velocity.z = normalised.y * speed

func player_rotation() -> void:
	player.sprite3d.rotation.y = player.camera_3d.rotation.y

func check_ceiling() -> bool:
	ceiling_checker.force_shapecast_update()
	if ceiling_checker.is_colliding():
		return true
	else:
		return false

func climb() -> void:
	wall_normal = player.get_wall_normal()
	player.velocity = Vector3(wall_normal.z, wall_normal.y, -wall_normal.x) * player.input_dir.x * climb_speed
	player.velocity.y = -player.input_dir.y * climb_speed
