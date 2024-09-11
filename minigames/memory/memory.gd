extends Node2D

@export_range(0.1, 1, 0.1) var show_time: float
@export_range(1, 100, 1) var max_buttons: int

@onready var buttons_parent: Node = $button
@onready var timer: Timer = $Timer
@onready var label: Label = $Label

var buttons: Array[TextureButton]
var random_order: Array[int]

var current_state: int = 0 #0 - starting, 1 - buttons showing, 2 - click buttons
var current_button: int = 0
var total_buttons: int = 0

func _ready() -> void:
	for i in buttons_parent.get_child_count():
		var but: TextureButton = buttons_parent.get_child(i)
		buttons.append(but)
		but.mouse_entered.connect(hover.bind(i))
		but.pressed.connect(press.bind(i))
	current_state = 1
	count()

func hover(button: int) -> void:
	buttons[button].grab_focus()

func press(button: int) -> void:
	if current_state == 2:
		if button == random_order[current_button]:
			if current_button == total_buttons:
				if total_buttons < max_buttons - 1:
					total_buttons += 1
					current_state = 1
					current_button = 0
					count()
					if get_viewport().gui_get_focus_owner():
						get_viewport().gui_get_focus_owner().release_focus()
				else:
					win()
			else:
				current_button += 1
		else:
			end()

func count() -> void:
	if current_state == 1:
		if len(random_order) == current_button:
			var num: int = randi_range(0, 8)
			random_order.append(num)
		buttons[random_order[current_button]].disabled = true
		timer.start(show_time)

func _on_timer_timeout() -> void:
	if current_state == 1:
		buttons[random_order[current_button]].disabled = false
		current_button += 1
		if current_button <= total_buttons:
			count()
		else:
			current_state = 2
			current_button = 0
	elif current_state == 3:
		get_tree().change_scene_to_file("res://minigames/minigames.tscn")

func win() -> void:
	label.text = "You win"
	end()

func end() -> void:
	current_state = 3
	timer.start(0.5)
