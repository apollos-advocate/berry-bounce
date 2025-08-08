extends Node

const SAVE_PATH := "user://save_file.json"

# --- Player Stats ---
var berry_count: int = 0
var max_health: int = 5
var current_health: int = max_health

# --- Levels ---
var unlocked_levels: Array = [1] # Level 1 unlocked by default
var current_level: int = 1

# --- Level Scene Paths ---
var level_scenes := {
	1: "res://Levels/Level1.tscn",
	2: "res://Levels/Level2.tscn",
	3: "res://Levels/Level3.tscn",
	4: "res://Levels/Level4.tscn",
	5: "res://Levels/Level5.tscn",
	6: "res://Levels/Level6.tscn",
	7: "res://Levels/Level7.tscn",
	8: "res://Levels/Level8.tscn",
	9: "res://Levels/Level9.tscn",
	10: "res://Levels/Level10.tscn"
}

func _ready() -> void:
	_load_game()

# --- Berries ---
func add_berries(amount: int) -> void:
	berry_count += amount
	_update_hud()
	_save_game()

# --- Levels ---
func unlock_level(level_num: int) -> void:
	if level_num not in unlocked_levels:
		unlocked_levels.append(level_num)
		unlocked_levels.sort()
	_save_game()

func get_next_level_path() -> String:
	return level_scenes.get(current_level + 1, "")

# --- HUD Update Helper ---
func _update_hud() -> void:
	var current_scene = get_tree().current_scene
	if current_scene:
		var hud = current_scene.get_node_or_null("HUD")
		if hud:
			hud.update_berry_count(berry_count)
			hud.update_health(current_health, max_health)

# --- Save / Load ---
func _save_game() -> void:
	var save_data = {
		"berry_count": berry_count,
		"max_health": max_health,
		"current_health": current_health,
		"unlocked_levels": unlocked_levels,
		"current_level": current_level,
	}

	var json = JSON.new()
	var json_string = json.stringify(save_data)

	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(json_string)
		file.close()
	else:
		push_error("Failed to open save file for writing: %s" % SAVE_PATH)

func _load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		print("No save file found. Starting new game.")
		_save_game()  # create fresh save file
		return

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not file:
		push_error("Failed to open save file for reading: %s" % SAVE_PATH)
		return

	var content = file.get_as_text()
	file.close()

	var parse_result = JSON.parse_string(content)
	if parse_result.error != OK:
		push_error("Error parsing save file: %s" % parse_result.error_string)
		return

	if parse_result.result is Dictionary:
		var data = parse_result.result as Dictionary
		berry_count = int(data.get("berry_count", 0))
		max_health = int(data.get("max_health", 5))
		current_health = int(data.get("current_health", max_health))
		unlocked_levels = data.get("unlocked_levels", [1])
		if typeof(unlocked_levels) != TYPE_ARRAY:
			unlocked_levels = [1]
		current_level = int(data.get("current_level", 1))
	else:
		push_error("Save file content is not a valid dictionary")
