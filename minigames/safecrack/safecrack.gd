extends Node2D

@export_range(1, 100, 1) var code_length: int
@export_range(0, 1, 0.1) var wait_time: float = 0

@onready var label: Label = $Label
@onready var label_2: Label = $Label2
@onready var dial: Sprite2D = $dial
@onready var timer: Timer = $Timer

var code: Array[int]
var input_dir: float = 0
var num: int = 1
var choosing_right_number: bool

var won: bool = false

func _ready() -> void:
	for i in code_length:
		var rand_num: int = randi_range(1, 8)
		code.append(rand_num)
	set_text()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left"):
		change_num(-1)
	if Input.is_action_just_pressed("right"):
		change_num(1)
	dial.rotation = lerp_angle(dial.rotation, PI / 4 * num - PI / 4, 0.2)

func set_text() -> void:
	label.text = ""
	for i in code.size():
		label.text += str(code[i])
		if i < code.size() - 1:
			label.text += ", \n"

func change_num(change: int) -> void:
	choosing_right_number = false
	num += change
	if num < 1:
		num += 8
	if num > 8:
		num -= 8
	label_2.text = str(num)
	
	if num == code[0]:
		choosing_right_number = true
		timer.start(wait_time)

func win() -> void:
	won = true
	timer.start(0.5)

func _on_timer_timeout() -> void:
	if won:
		if unlocks.cube_1_4:
			get_tree().change_scene_to_file("res://minigames/minigames.tscn")
		else:
			if won:
				unlocks.cubes += 1
				unlocks.cube_1_4 = true
			get_tree().change_scene_to_file("res://3D/city.tscn")
	if choosing_right_number:
		code.pop_front()
		set_text()
		if code.size() == 0:
			win()
