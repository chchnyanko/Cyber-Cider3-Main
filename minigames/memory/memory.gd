extends Node2D

@export_range(0.1, 1, 0.1) var show_time: float
@export_range(1, 100, 1) var max_buttons: int

@onready var buttons_parent: Node = $button
@onready var timer: Timer = $Timer
@onready var label: Label = $Label
@onready var animation: AnimationPlayer = $AnimationPlayer

var buttons: Array[TextureButton]
var random_order: Array[int]

var current_state: int = 0 #0 - starting, 1 - buttons showing, 2 - click buttons
var current_button: int = 0
var total_buttons: int = 0
var won: bool = false

func _ready() -> void:
	for i in buttons_parent.get_child_count():
		var but: TextureButton = buttons_parent.get_child(i)
		buttons.append(but)
		but.mouse_entered.connect(hover.bind(i))
		but.mouse_exited.connect(unhover.bind(i))
		but.pressed.connect(press.bind(i))
	current_state = 1
	count()

func hover(button: int) -> void:
	buttons[button].grab_focus()
	buttons[button].get_child(0).play("hover")

func unhover(button: int) -> void:
	buttons[button].get_child(0).play("not pressed")

func press(button: int) -> void:
	buttons[button].get_child(0).play("pressed")
	if current_state == 2:
		if button == random_order[current_button]:
			if current_button == total_buttons:
				if total_buttons < max_buttons - 1:
					total_buttons += 1
					current_state = 1
					current_button = 0
					count()
					animation.play("correct")
					if get_viewport().gui_get_focus_owner():
						get_viewport().gui_get_focus_owner().release_focus()
				else:
					win()
			else:
				current_button += 1
		else:
			animation.play("wrong")
			end()

func count() -> void:
	if current_state == 1:
		if len(random_order) == current_button:
			var num: int = randi_range(0, 8)
			random_order.append(num)
		buttons[random_order[current_button]].get_child(0).play("show")
		timer.start(show_time)

func _on_timer_timeout() -> void:
	if current_state == 1:
		buttons[random_order[current_button]].get_child(0).play("not pressed")
		current_button += 1
		if current_button <= total_buttons:
			count()
		else:
			animation.play("done")
			current_state = 2
			current_button = 0
	elif current_state == 3:
		if unlocks.cube_1_5:
			get_tree().change_scene_to_file("res://minigames/minigames.tscn")
		else:
			if won:
				unlocks.cubes += 1
				unlocks.cube_1_5 = true
			get_tree().change_scene_to_file("res://3D/city.tscn")

func win() -> void:
	won = true
	label.text = "You win"
	end()

func end() -> void:
	current_state = 3
	timer.start(0.5)
