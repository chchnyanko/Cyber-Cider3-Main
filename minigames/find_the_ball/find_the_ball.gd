extends Node2D

enum states {fall, move, select, winlose}

@export_range(1, 100) var max_moves: int ## The number of moves that the cups will do before you can click them
@export_range(0.01, 0.9) var speed: float ## The speed at which the cups will be moving

@onready var ball: Sprite2D = $Ball

@onready var cup: TextureButton = $Cup
@onready var cup2: TextureButton = $Cup2
@onready var cup3: TextureButton = $Cup3

@onready var label: Label = $Label
@onready var timer: Timer = $Timer

var cup_positions: Array[float]
var current_state: int = 0
var move: int = 0 # the number of moves that the cups have done so far

var cup_target: float
var cup2_target: float
var cup3_target: float

var won: bool = false

func _ready() -> void:
	for i in get_tree().get_node_count_in_group("cup"):
		cup_positions.append(get_tree().get_nodes_in_group("cup")[i].position.x)
		get_tree().get_nodes_in_group("cup")[i].pressed.connect(cup_pressed.bind(i))
	cup_target = cup_positions[0]
	cup2_target = cup_positions[1]
	cup3_target = cup_positions[2]

func _process(delta: float) -> void:
	if current_state == 0: #fall
		if cup.position.y < 480:
			cup.position.y += 10
			cup2.position.y += 10
			cup3.position.y += 10
		else:
			ball.hide()
			current_state += 1
	if current_state == 1: #move
		if move < max_moves:
			cup.position.x = lerp(cup.position.x, cup_positions[0], speed)
			cup2.position.x = lerp(cup2.position.x, cup_positions[1], speed)
			cup3.position.x = lerp(cup3.position.x, cup_positions[2], speed)
			if abs(cup.position.x - cup_positions[0]) < 1 and abs(cup2.position.x - cup_positions[1]) < 1 and abs(cup3.position.x - cup_positions[2]) < 1:
				cup_positions.shuffle()
				move += 1
				speed *= 1.001
				speed = clampf(speed, 0.01, 0.9)
		else:
			current_state += 1
	if current_state == 3: #lift
		if cup.position.y > 200:
			cup.position.y -= 10
			cup2.position.y -= 10
			cup3.position.y -= 10
		else:
			if won:
				label.text = "You won"
			else:
				label.text = "You lost"
			current_state += 1
			timer.start(0.5)

func win() -> void:
	won = true

func clicked() -> void:
	current_state = 3
	ball.position.x = cup2.position.x + 115
	ball.show()

func cup_pressed(cup) -> void:
	if current_state == 2:
		clicked()
		if cup == 1:
			win()

func _on_timer_timeout() -> void:
	if current_state == 4:
		if unlocks.cube_1_1:
			get_tree().change_scene_to_file("res://minigames/minigames.tscn")
		else:
			if won:
				unlocks.cubes += 1
				unlocks.cube_1_1 = true
			get_tree().change_scene_to_file("res://3D/city.tscn")
