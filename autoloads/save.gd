extends Node

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
	var save_file = FileAccess.open("user://save.data", FileAccess.READ)
	var save_data: Array
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		save_data.append(json.get_data())
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
