extends Node

class_name ui_cursor

var buttons: Array[Node]

var focus_node: Node

var current_scene: Node

func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS

func scene_changed():
	buttons.clear()
	buttons = get_tree().get_nodes_in_group("ui_button")
	for button in buttons:
		if button is Button:
			button.pressed.connect(button_pressed.bind(button))
			button.mouse_entered.connect(hover.bind(button))

func _process(delta: float) -> void:
	if current_scene != get_tree().current_scene:
		current_scene = get_tree().current_scene
		if current_scene == null:
			return
		await get_tree().process_frame
		scene_changed()
		return
	focus_node = get_viewport().gui_get_focus_owner()
	if focus_node:
		for i in buttons.size():
			var focus: int = buttons.find(focus_node)
			var pos_y: float
			if i < focus:
				pos_y = i * 150
			if i > focus:
				pos_y = get_viewport().get_visible_rect().size.y - (buttons.size() - i) * 150
			if i == focus:
				pos_y = get_viewport().get_mouse_position().y - 50
				pos_y = clamp(pos_y, (i - 1) * 150 + 150, get_viewport().get_visible_rect().size.y - (buttons.size() - i - 1) * 150 - 150)
			buttons[i].position.y = lerp(buttons[i].position.y, pos_y, 0.5)
		return
	if Input.is_anything_pressed():
		if get_tree().get_nodes_in_group("ui_button"):
			get_tree().get_first_node_in_group("ui_button").grab_focus()

func button_pressed(button) -> void:
	print("button pressed ", button)
	
	if button.has_meta("save"):
		if button.get_meta("save"):
			data.save_game()
		else:
			data.load_game()
	# Scene has to be the last one so that the scene doesn't change before everything else changes
	if button.has_meta("scene"):
		print(button.get_meta("scene"))
		get_tree().paused = false
		get_tree().change_scene_to_file(str("res://", button.get_meta("scene"), ".tscn"))

func hover(button) -> void:
	button.grab_focus()
