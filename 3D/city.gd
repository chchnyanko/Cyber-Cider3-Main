extends Node3D

func _ready() -> void:
	if data.tutorial:
		return
	$Yarts.change_state($Yarts.statemachine.cut_scene, "tutorial")
	
	data.tutorial = true
	music.change_song()
	
	%objective.text += "\nMove with WASD and use mouse to move the camera"

func set_level():
	%objective.text += str("Find Cube Pieces to get to the top of the tower")
	if unlocks.cubes != 12:
		%objective.text += str("\nFound Cube Pieces ", unlocks.cubes % 6, " / 6")
	if unlocks.cubes == 6:
		%objective.text += str("\nYou unlocked dive. Press shift to dive mid-air")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if unlocks.crawl == false:
		if unlocks.cube_1_1 and unlocks.cube_1_2 and unlocks.cube_1_3 and unlocks.cube_1_4 and unlocks.cube_1_5 and unlocks.cube_1_6:
			unlocks.crawl = true
			unlocks.dive = true 
	if unlocks.climb == false:
		if unlocks.cube_2_1 and unlocks.cube_2_2 and unlocks.cube_2_3 and unlocks.cube_2_4 and unlocks.cube_2_5 and unlocks.cube_2_6:
			unlocks.climb = true

func _on_top_of_tower_body_entered(body: Node3D) -> void:
	if body is yarts:
		body.change_state(body.statemachine.cut_scene, "end")
