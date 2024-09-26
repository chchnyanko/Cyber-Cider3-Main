extends Node2D

@export_range(1, 10, 1) var number_of_items: int
@export_range(0, 10, 1) var number_of_fake_items: int

@onready var potion: PackedScene = preload("res://minigames/potion_making/potion.tscn")
@onready var instruction: RichTextLabel = $RichTextLabel
@onready var timer: Timer = $Timer
@onready var cauldron: AnimatedSprite2D = $cauldron/cauldron
@onready var fail: AnimatedSprite2D = $fail

const ingredients: Dictionary = {
	"carrot": ["color", "#ffa600"],
	"radish": ["pulse", "freq=1.0 color=#000000 ease=-2.0"],
	"cherry": ["shake", "rate=100"],
	"egg": ["wave", "amp=1"],
	"cat": ["rainbow", "freq=1 sat=1 val=1"]
}

var needed_ingredients: Array
var won: bool = false

func _ready() -> void:
	set_text()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		remove_item()

func remove_item(item_name: String = ""):
	if item_name == "":
		needed_ingredients.remove_at(0)
	else:
		if item_name in needed_ingredients:
			needed_ingredients.erase(item_name)
		else:
			fail.show()
			fail.play("kaboom")
			timer.start(0.75)
	set_text(true)
	if needed_ingredients.size() == 0:
		win()
		return

func set_text(resetting: bool = false):
	instruction.text = "To make the potion you must bring these ingredients and place them in my cauldron \n"
	if resetting:
		for i in needed_ingredients.size():
			instruction.text += get_text(needed_ingredients[i])
			if i < needed_ingredients.size() - 1:
				instruction.text += ", \n"
	else:
		for i in number_of_items:
			var ingredient = get_random_ingredient()
			instruction.text += get_text(ingredient)
			needed_ingredients.append(ingredient)
			if i < number_of_items - 1:
				instruction.text += ", \n"
			create_item(ingredient)
		for i in number_of_fake_items:
			var ingredient = get_random_ingredient()
			create_item(ingredient)

func create_item(item_name: String):
	var potion_instance = potion.instantiate()
	add_child(potion_instance)
	potion_instance.set_item_name(item_name)
	potion_instance.change_position()

func get_random_ingredient() -> String:
	return ingredients.keys()[randi_range(0, ingredients.size()-1)]

func get_text(text: String = "random") -> String:
	if text == "random":
		text = get_random_ingredient()
	text = str("[", ingredients.get(text)[0], "=", ingredients.get(text)[1], "]", text, "[/", ingredients.get(text)[0], "]")
	return text

func _on_cauldron_area_entered(area: Area2D) -> void:
	if area is potion:
		cauldron.play("item_in")
		remove_item(area.get_item())
		area.queue_free()

func win():
	cauldron.play("complete")
	won = true
	timer.start(1)

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://minigames/minigames.tscn")
