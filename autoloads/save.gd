extends Node

var tutorial: bool = false #stores if the player has seen the tutorial in the past

var checkpoint_pos: Vector3 = Vector3.ZERO
var checkpoint_name: String = "none"

func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS

func save_game() -> void:
	var save_file = FileAccess.open("user://save.data", FileAccess.WRITE)
	var unlock_data = inst_to_dict(unlocks)
	unlock_data.erase("@subpath")
	unlock_data.erase("@path")
	var save_unlock_data = JSON.stringify(unlock_data)
	save_file.store_line(save_unlock_data)
	var player_data = inst_to_dict(self)
	player_data.erase("@subpath")
	player_data.erase("@path")
	var save_player_data = JSON.stringify(player_data)
	save_file.store_line(save_player_data)
	save_file.close()

func load_game():
	if !FileAccess.file_exists("user://save.data"):
		return
	var save_file = FileAccess.open("user://save.data", FileAccess.READ)
	var save_data: Array
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		save_data.append(json.get_data())
	if len(save_data) > 2:
		for i in save_data[0].keys():
			unlocks.set(i, save_data[0][i])
		for i in save_data[1].keys():
			set(i, save_data[1][i])
			if i == "checkpoint_pos":
				save_data[1][i] = save_data[1][i].replace("(", "").replace(")", "")
				checkpoint_pos.x = float(save_data[1][i].get_slice(",", 0))
				checkpoint_pos.y = float(save_data[1][i].get_slice(",", 1))
				checkpoint_pos.z = float(save_data[1][i].get_slice(",", 2))
	save_file.close()

func save_settings():
	var setting = FileAccess.open("user://settings.data", FileAccess.WRITE)
	var settings_data = inst_to_dict(settings)
	settings_data.erase("@subpath")
	settings_data.erase("@path")
	var save_settings_data = JSON.stringify(settings_data)
	setting.store_line(save_settings_data)
	setting.close()

func load_settings():
	if !FileAccess.file_exists("user://settings.data"):
		return
	var setting = FileAccess.open("user://settings.data", FileAccess.READ)
	var setting_data: Array
	while setting.get_position() < setting.get_length():
		var json_string = setting.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		setting_data.append(json.get_data())
	if setting_data != []:
		for i in setting_data[0].keys():
			settings.set(i, setting_data[0][i])
	setting.close()
