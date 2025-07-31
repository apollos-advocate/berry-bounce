extends Node

const SAVE_PATH = "user://save_data.json"

var data = {
	"unlocked_levels": 1,
	"berry_count": 0,
	"purchased_items": []
}

func _ready():
	load_game()

func save_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()
	print("Game saved.")

func load_game():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		var content = file.get_as_text()
		var loaded = JSON.parse_string(content)
		if typeof(loaded) == TYPE_DICTIONARY:
			data = loaded
		file.close()
		print("Game loaded:", data)
	else:
		print("No save file found. Using defaults.")
