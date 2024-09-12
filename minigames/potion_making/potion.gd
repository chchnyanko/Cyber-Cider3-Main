extends Area2D

class_name potion

@onready var label: RichTextLabel = $label

var moving: bool = false
var item_name: String

func set_item_name(new_item_name: String):
	item_name = new_item_name

func change_text(new_text: String):
	label.text = new_text

func change_position():
	position.x = randi_range(0, 1000)
	position.y = randi_range(0, 1000)

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

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed == true:
			moving = true
		else:
			moving = false

func get_item() -> String:
	return item_name
