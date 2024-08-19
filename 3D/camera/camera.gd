extends Node3D

class_name camera

@export var target: Node ## The node / player that the camera will be following
@export var distance: float ## The distance that the camera will be away from the player or set to 0 for first person camera

@onready var camera_3d: Camera3D = $Camera3D
@onready var ray: RayCast3D = $RayCast3D

var target_pos: Vector3
var camera_pos: Vector3 = Vector3.ZERO
var ray_distance: float

func _ready():
	ray.target_position.z = distance
	ray.add_exception(target)
	camera_pos.z = distance

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation.y -= event.velocity.x * 0.00005
		rotation.x -= event.velocity.y * 0.00005

func _physics_process(delta: float) -> void:
	target_pos = target.global_transform.origin
	
	position = target_pos
	
	ray.force_raycast_update()
	
	if ray.is_colliding():
		camera_3d.global_transform.origin = ray.get_collision_point()
	else:
		camera_3d.position = camera_pos
