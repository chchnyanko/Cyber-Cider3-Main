extends Node2D

func _ready() -> void:
	data.load_settings()
	data.load_game()
	if data.checkpoint_name == "none":
		$last_checkpoint.text = str("Start New Game")
	else:
		$last_checkpoint.text = str("Last Checkpoint: ", data.checkpoint_name)
	
