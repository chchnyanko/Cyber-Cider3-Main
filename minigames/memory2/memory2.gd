extends Node2D

@export_range(1, 10, 1) var width: int = 1
@export_range(2, 10, 2) var height: int = 2

@onready var grid: GridContainer = $grid
@onready var timer: Timer = $Timer

var colours: Array[Color]
var block_colours: Dictionary
var clicked_blocks: Vector2i
var cleared_blocks: Array[int]

func _ready() -> void:
	grid.size = Vector2(width * 110 - 10, height * 110 - 10)
	grid.position = Vector2(960 - grid.size.x / 2, 540 - grid.size.y / 2)
	grid.columns = width
	spawn_blocks(width * height)
	set_colours(width * height / 2)

func reset_colours():
	if !cleared_blocks.has(clicked_blocks.x):
		grid.get_child(clicked_blocks.x - 1).color = Color(0, 0, 0, 1)
	if !cleared_blocks.has(clicked_blocks.y):
		grid.get_child(clicked_blocks.y - 1).color = Color(0, 0, 0, 1)

func get_random_colour() -> Color:
	var colour: Color = colours.pick_random()
	if block_colours.find_key(colour):
		colours.erase(colour)
	return colour

func set_colours(num: int):
	for i in num:
		var colour: Color = Color(randf(), randf(), randf(), 1)
		colours.append(colour)

func spawn_blocks(num: int):
	for i in num:
		var block: ColorRect = ColorRect.new()
		grid.add_child(block)
		block.color = Color(0, 0, 0, 1)
		block.custom_minimum_size = Vector2(100, 100)
		block.name = str("block", i + 1)

func clicked(block: int) -> void:
	if cleared_blocks.has(block):
		return
	if clicked_blocks.y != 0:
		await reset_colours()
		clicked_blocks = Vector2.ZERO
	if clicked_blocks.x == 0:
		clicked_blocks.x = block
	elif clicked_blocks.x != block:
		clicked_blocks.y = block
		if block_colours.get(clicked_blocks.x) == block_colours.get(clicked_blocks.y):
			cleared_blocks.append(clicked_blocks.x)
			cleared_blocks.append(clicked_blocks.y)
			if cleared_blocks.size() == width * height:
				win()
	if !block_colours.get(block):
		var colour: Color = get_random_colour()
		block_colours[block] = colour
		grid.get_child(block - 1).color = colour
	else:
		grid.get_child(block - 1).color = block_colours[block]

func pressed(pos: Vector2):
	var left_pos: int = grid.position.x
	if pos.x > left_pos and pos.x < left_pos + grid.size.x:
		pos.x = int((pos.x - left_pos) / 110)
	else:
		return
	var top_pos: int = grid.position.y
	if pos.y > top_pos and pos.y < top_pos + grid.size.y:
		pos.y = int((pos.y - top_pos) / 110)
	else:
		return
	var block: int = pos.x + pos.y * width
	clicked(block + 1)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			pressed(event.position)

func win():
	timer.start(1)

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://minigames/minigames.tscn")
