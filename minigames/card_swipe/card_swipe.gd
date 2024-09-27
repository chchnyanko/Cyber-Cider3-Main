extends Node2D

@export_range(0, 10, 0.1) var max_time: float ## The maximum amount of time to play this game
@export_range(0, 1, 0.1) var position_smoothing: float
@export_range(0, 1, 0.1) var min_card_swipe_time: float ## The minimum time that the card swipe can take
@export_range(0, 1, 0.1) var random_range_card_swipe_time: float ## The random difference of the time
@export_range(0.2, 1, 0.1) var range_card_swipe_time: float ## The time range that the player is allowed to swipe the card

@onready var timer: TextureProgressBar = $TextureProgressBar
@onready var card_swipe_timer: Timer = $card_swipe_timer
@onready var tick_clock: Timer = $Timer
@onready var indicator: ColorRect = $indicator ## the indicator for if you swiped well or not
@onready var card: Area2D = $card
@onready var label: Label = $Label

var movable: bool = false
var moving: bool = false
var swiping: bool = false
var won: bool = false
var target_colour: Color = Color(0, 0, 0, 0)

func _ready() -> void:
	if max_time > 0:
		timer.max_value = max_time * 10
		timer.value = max_time * 10
		tick_clock.start(0.1)
	movable = true

func _process(delta: float) -> void:
	if moving:
		card.position = lerp(card.position, get_viewport().get_mouse_position(), position_smoothing)
		card.position.x = clampf(card.position.x, 300, 1620)
		card.position.y = clampf(card.position.y, 150, 800)
		card.rotation = lerp_angle(card.rotation, card.get_angle_to(get_viewport().get_mouse_position()), 0.1)
		card.rotation = clampf(card.rotation, -PI/8, PI/8)
	indicator.color = lerp(indicator.color, target_colour, 0.1)

func _on_timer_timeout() -> void:
	timer.value -= 1
	if timer.value == 0 or won and timer.value != -11:
		if won:
			label.text = "You win"
		else:
			label.text = "You lose"
		timer.value = -10
		tick_clock.start(0.5)
	elif timer.value == -11:
		if unlocks.cube_1_2:
			get_tree().change_scene_to_file("res://minigames/minigames.tscn")
		else:
			if won:
				unlocks.cube_1_2 = true
				unlocks.cubes += 1
			get_tree().change_scene_to_file("res://3D/city.tscn")
	else:
		tick_clock.start(0.1)

func _on_card_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if movable:
		if event is InputEventMouseButton:
			if event.pressed == true:
				moving = true
			else:
				moving = false

func _on_area_2d_area_entered(area: Area2D) -> void: #entry
	if area == card:
		swiping = true
		card_swipe_timer.start(min_card_swipe_time + randf_range(0, random_range_card_swipe_time))

func _on_area_2d_2_area_entered(area: Area2D) -> void: #exit
	if area == card:
		if swiping:
			swiping = false
			if card_swipe_timer.time_left < range_card_swipe_time and card_swipe_timer.time_left > 0:
				success()
			else:
				fail()

func success():
	target_colour = Color(0, 1, 0, 0.5)
	movable = false
	card_swipe_timer.stop()
	won = true

func fail():
	target_colour = Color(1, 0, 0, 0.5)
