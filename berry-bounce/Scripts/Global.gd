extends Node

# Persistent player data
var berry_count: int = 0
var unlocked_hats: Array = []
var current_hat: String = ""
var chosen_character: String = "Strawberry"
var unlocked_levels: Array = [1]

# Save path
const SAVE_PATH := "user://save.json"

func _ready():
	load_game()

# ---- Save & Load ----
func save_game():
	var data = {
		"berry_count": berry_count,
		"unlocked_hats": unlocked_hats,
		"current_hat": current_hat,
		"chosen_character": chosen_character,
		"unlocked_levels": unlocked_levels
	}
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data, "\t"))

func load_game():
	if not FileAccess.file_exists(SAVE_PATH):
		return
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		var content = file.get_as_text()
		var data = JSON.parse_string(content)
		if typeof(data) == TYPE_DICTIONARY:
			berry_count = data.get("berry_count", 0)
			unlocked_hats = data.get("unlocked_hats", [])
			current_hat = data.get("current_hat", "")
			chosen_character = data.get("chosen_character", "Strawberry")
			unlocked_levels = data.get("unlocked_levels", [1])

# ---- Utility ----
func add_berries(amount: int):
	berry_count += amount
	save_game()

func unlock_hat(hat_name: String):
	if hat_name not in unlocked_hats:
		unlocked_hats.append(hat_name)
	save_game()

func equip_hat(hat_name: String):
	if hat_name in unlocked_hats:
		current_hat = hat_name
	save_game()
