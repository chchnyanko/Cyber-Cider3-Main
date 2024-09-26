extends Area2D

class_name potion

@onready var sprite: AnimatedSprite2D = $sprite

var moving: bool = false
var item_name: String

func set_item_name(new_item_name: String):
	item_name = new_item_name
	sprite.animation = new_item_name

func change_position():
	position.x = randi_range(100, 1000)
	position.y = randi_range(100, 1000)

func _process(delta: float) -> void:
	if moving:
		position = lerp(position, get_viewport().get_mouse_position(), 0.5)
		position.x = clampf(position.x, 50, 1870)
		position.y = clampf(position.y, 50, 1030)
		rotation = lerp_angle(rotation, get_angle_to(get_viewport().get_mouse_position()), 0.1)
		rotation = clampf(rotation, -PI/8, PI/8)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed == false:
			moving = false

func _on_mouse_entered() -> void:
	sprite.play(str(item_name, "_hover"))

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed == true:
			moving = true
			sprite.play(str(item_name, "_pressed"))
		else:
			moving = false

func get_item() -> String:
	return item_name
