extends Node

class_name ui_cursor

@export var cursor : TextureProgressBar ## The cursor node
@export var line : Line2D ## The line2d that follows the cursor
@export var first_focus : Button ## The first button that will be focussed when a key is pressed
@export var pause_screen : Node ## The pause screen for when pausing the game from a button
@export var animation: AnimationPlayer ## The animation player that will make the cider pour

var positions : Dictionary #stores the default position of each button
var focus_node : Control #the node that is currently being focused
var lines : Array #stores the names of the underlines for each button

#called when this node is first instanced into the scene
func _ready():
	#hide the cursor
	cursor.position.y = first_focus.position.y
	cursor.hide()
	#for each of the children of the parent node
	for child in get_tree().get_nodes_in_group("ui_button"):
		#add it's position to the positions dictionary
		positions[child] = child.position
		#connect it's signals
		child.mouse_entered.connect(hover.bind(child))
		if child is Button:
			child.pressed.connect(button_pressed.bind(child))
			var new_line = Line2D.new()
			new_line.add_point(new_line.position + Vector2(0, child.size.y))
			new_line.add_point(new_line.position + Vector2(0, child.size.y))
			child.add_child(new_line)
			lines.append(new_line)

#called each process frame
func _process(_delta):
	#store the node that is currenly being focussed
	focus_node = get_viewport().gui_get_focus_owner()
	#if there isn't any node being focussed
	if !focus_node:
		#if the player presses any button, make the first focus node grab focus
		if Input.is_anything_pressed():
			first_focus.grab_focus()
		return
	#if there is a node being focussed
	#show the cursor
	cursor.show()
	#set the position for the cursor and the line following it
	cursor.position = lerp(cursor.position, focus_node.position - Vector2(50, 0), 0.3)
	line.points[0] = cursor.position
	line.points[1] = lerp(line.points[1], cursor.position, 0.2)
	
	for button in positions.keys():
		if button is Button:
			var underline = button.get_child(0)
			if button == focus_node:
				underline.points[1] = lerp(underline.points[1], underline.points[0] + Vector2(focus_node.size.x, 0), 0.2)
			else:
				underline.points[1] = lerp(underline.points[1], underline.points[0], 0.5)
	
	#for each of the buttons move them depending on where the cursor currently is
	for button in positions.keys():
		button.position.y = positions[button].y + (positions[button].y - cursor.position.y) / 2

#called when a button is pressed
func button_pressed(button):
	
	#pouring cider animation
	if animation != null:
		animation.play("pour_cider")
		await animation.animation_finished
	
	get_viewport().gui_get_focus_owner().release_focus()
	
	if button.has_meta("save"):
		if button.get_meta("save"):
			data.save_game()
		else:
			data.load_game()
	# Scene has to be the last one so that the scene doesn't change before everything else changes
	if button.has_meta("scene"):
		print(button.get_meta("scene"))
		get_tree().paused = false
		get_tree().change_scene_to_file(str("res://", button.get_meta("scene"), ".tscn"))
	
	cursor.value = 30
	cursor.rotation = 0

#called when the mouse enters a button
func hover(button):
	#make the button grab focus
	button.grab_focus()
