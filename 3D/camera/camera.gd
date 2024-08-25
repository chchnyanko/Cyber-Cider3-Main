extends Node3D

class_name camera

@export var target: Node ## The node / player that the camera will be following

@onready var camera_3d: Camera3D = $Camera3D
@onready var ray: RayCast3D = $RayCast3D

var distance: float ## The distance that the camera will be away from the player or set to 0 for first person camera
var target_pos: Vector3
var camera_pos: Vector3 = Vector3.ZERO
var ray_distance: float
var sensitivity: float
var moving: bool = true #if the camera is currently able to move or not

func _ready():
	sensitivity = settings.get("camera_sensitivity")
	distance = settings.get("camera_distance")
	ray.target_position.z = distance
	ray.add_exception(target)
	camera_pos.z = distance

func _input(event: InputEvent) -> void:
	if !moving:
		return
	if event is InputEventMouseMotion:
		rotation.y -= event.velocity.x * 0.0005 * sensitivity
		rotation.x -= event.velocity.y * 0.0005 * sensitivity
		rotation.x = clamp(rotation.x, -PI/2 + 0.5, PI/2 - 0.5)

func _physics_process(delta: float) -> void:
	target_pos = target.global_transform.origin
	
	position = target_pos
	
	ray.force_raycast_update()
	
	if ray.is_colliding():
		camera_3d.global_transform.origin = ray.get_collision_point()
	else:
		camera_3d.position = camera_pos

func update_moving(hi: bool) -> void:
	moving = hi
