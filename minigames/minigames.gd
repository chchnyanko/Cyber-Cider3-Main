extends Control

const MINIGAMES: Array[String] = [
	"res://minigames/find_the_ball/find_the_ball.tscn",#
	"res://minigames/card_swipe/card_swipe.tscn",#
	"res://minigames/platformer/platformer.tscn",#
	"",
	#"res://minigames/pinball/pinball.tscn",
	"res://minigames/memory/memory.tscn",#
	"res://minigames/simon_says/simon_says.tscn",#
	
	"res://minigames/boulder_escape/boulder_escape.tscn",
	"res://minigames/match-a-block/match-a-block.tscn",
	"res://minigames/potion_making/potion_making.tscn",
	"res://minigames/shootout/shootout.tscn",
	"res://minigames/memory2/memory2.tscn",
	"res://minigames/drop_the_ball/drop_the_ball.tscn"
]

func _ready() -> void:
	for i in get_tree().get_node_count_in_group("button"):
		get_tree().get_nodes_in_group("button")[i].pressed.connect(button_pressed.bind(i))

func button_pressed(button: int) -> void:
	await $cursor_animation.animation_finished
	get_tree().change_scene_to_file(MINIGAMES[button])
