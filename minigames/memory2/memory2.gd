extends Node2D

@onready var timer: Timer = $Timer
@onready var cards_parent: Node = $cards_parent

var cards_left: Array[int]
var cards: Dictionary
var clicked_cards: Vector2i
var cleared_cards: Array[int]

func _ready() -> void:
	for i in 5:
		cards_left.append(i)

func reset_colours():
	if !cleared_cards.has(clicked_cards.x):
		cards_parent.get_child(clicked_cards.x - 1).animation = "back"
	if !cleared_cards.has(clicked_cards.y):
		cards_parent.get_child(clicked_cards.y - 1).animation = "back"

func get_random_colour() -> int:
	var card: int = cards_left.pick_random()
	if cards.find_key(card):
		cards_left.erase(card)
	return card

func clicked(card: int) -> void:
	if cleared_cards.has(card):
		return
	if clicked_cards.y != 0:
		await reset_colours()
		clicked_cards = Vector2.ZERO
	if clicked_cards.x == 0:
		clicked_cards.x = card
	elif clicked_cards.x != card:
		clicked_cards.y = card
		if cards.get(clicked_cards.x) == cards.get(clicked_cards.y):
			cleared_cards.append(clicked_cards.x)
			cleared_cards.append(clicked_cards.y)
			if cleared_cards.size() == 10:
				win()
	if !cards.has(card):
		var colour: int = get_random_colour()
		cards[card] = colour
		cards_parent.get_child(card - 1).animation = str(colour)
	else:
		cards_parent.get_child(card - 1).animation = str(cards[card])

func pressed(pos: Vector2):
	var left_pos: int = 501
	if pos.x > left_pos and pos.x < 1429:
		pos.x = int((pos.x - left_pos) / 200)
	else:
		return
	var top_pos: int = 205
	if pos.y > top_pos and pos.y < top_pos + 861:
		pos.y = int((pos.y - top_pos) / 400)
	else:
		return
	var block: int = pos.x + pos.y * 5
	clicked(block + 1)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			pressed(event.position)

func win():
	timer.start(1)

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://minigames/minigames.tscn")
