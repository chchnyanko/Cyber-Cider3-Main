extends Node2D

@export_color_no_alpha var colours: Array[Color]
@export_range(1, 100, 1) var score_to_win: int

@onready var blocks_parent: Node = $blocks
@onready var cursor: Sprite2D = $cursor
@onready var timer: Timer = $Timer
@onready var label: Label = $Label

var blocks: Array
var block_colours: Array
var block_position: Array

var positions: Array
var cursor_pos: Vector2 = Vector2(2, 2)
var cursor_index: int

var score: int = 0

func _ready() -> void:
	label.text = str("Current score: ", score)
	for y in 5:
		for x in 5:
			var index: int = int(y * 5 + x)
			var block: ColorRect = blocks_parent.get_child(index)
			var random_colour = randi_range(0, colours.size() - 1)
			var colour: Color = colours[random_colour]
			blocks.append(block)
			block_colours.append(random_colour)
			block_position.append(index)
			positions.append(block.position)
			block.color = colour

func _process(delta: float) -> void:
	cursor_index = cursor_pos.x + cursor_pos.y * 5
	for block in blocks.size():
		blocks[block].position = lerp(blocks[block].position, positions[block_position[block]], 0.2)
	if Input.is_action_pressed("jump"):
		#region block movement
		var xinput: int = 0
		var yinput: int = 0
		if Input.is_action_just_pressed("left"):
			xinput = -1
		if Input.is_action_just_pressed("right"):
			xinput = 1
		if Input.is_action_just_pressed("up"):
			yinput = -1
		if Input.is_action_just_pressed("down"):
			yinput = 1
		if xinput != 0:
			var moving_blocks: Array = []
			for i in 5:
				var pos: int = cursor_index - cursor_pos.x + i
				var index: int = block_position.find(pos)
				moving_blocks.append(index)
			for i in 5:
				block_position[moving_blocks[i]] += xinput
				if i == 2 + xinput * 2: 
					block_position[moving_blocks[i]] -= 5 * xinput
		if yinput != 0:
			var moving_blocks: Array = []
			for i in 5:
				var pos: int = cursor_pos.x + 5 * i
				var index: int = block_position.find(pos)
				moving_blocks.append(index)
			for i in 5:
				block_position[moving_blocks[i]] += yinput * 5
				if i == 2 + yinput * 2:
					block_position[moving_blocks[i]] -= 25 * yinput
	#endregion
	else:
		#region cursor movement
		cursor.position = lerp(cursor.position, positions[cursor_index] + Vector2(15, 15), 0.2)
		if Input.is_action_just_pressed("up"):
			cursor_pos.y -= 1
		if Input.is_action_just_pressed("down"):
			cursor_pos.y += 1
		if Input.is_action_just_pressed("left"):
			cursor_pos.x -= 1
		if Input.is_action_just_pressed("right"):
			cursor_pos.x += 1
		if cursor_pos.x < 0:
			cursor_pos.x += 5
		if cursor_pos.x > 4:
			cursor_pos.x -= 5
		if cursor_pos.y < 0:
			cursor_pos.y += 5
		if cursor_pos.y > 4:
			cursor_pos.y -= 5
		#endregion
	#region detection
	for y in 5:
		var row_colour = null
		for x in 5:
			var index: int = x + y * 5
			var colour = block_colours[block_position.find(index)]
			if x == 0 or colour == row_colour:
				row_colour = colour
				if x == 4:
					clear_row("y", y)
				continue
			else:
				break
	for x in 5:
		var column_colour = null
		for y in 5:
			var index: int = x + y * 5
			var colour = block_colours[block_position.find(index)]
			if y == 0 or colour == column_colour:
				column_colour = colour
				if y == 4:
					clear_row("x", x)
				continue
			else:
				break
	#endregion

func clear_row(axis: String, row: int):
	score += 1
	label.text = str("Current score: ", score)
	if axis == "x":
		for i in 5:
			var index = row + i * 5
			var random_colour = randi_range(0, colours.size() - 1)
			var colour: Color = colours[random_colour]
			var pos = block_position.find(index)
			block_colours[pos] = random_colour
			blocks_parent.get_child(pos).color = colour
	if axis == "y":
		for i in 5:
			var index = row * 5 + i
			var random_colour = randi_range(0, colours.size() - 1)
			var colour: Color = colours[random_colour]
			var pos = block_position.find(index)
			block_colours[pos] = random_colour
			blocks_parent.get_child(pos).color = colour
	if score == score_to_win:
		win()

func win():
	if timer.time_left == 0:
		timer.start(0.5)

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://minigames/minigames.tscn")
