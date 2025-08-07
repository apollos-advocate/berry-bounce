extends Node

const SAVE_PATH := "user://save_file.json"

# --- Character Selection ---
var chosen_character_scene_path: String = ""

# --- Player Stats ---
var berry_count: int = 0
var max_health: int = 5
var current_health: int = max_health

# --- Levels ---
var unlocked_levels: Array = [1] # Level 1 unlocked by default
var current_level: int = 1

# --- Hats ---
var unlocked_hats: Array = []
var current_hat: String = ""

# --- Level Scene Paths ---
# So menus & "Next Level" always know what to load
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
	load_game()

# -------------------------
# Character
# -------------------------
func set_chosen_character(scene_path: String) -> void:
	chosen_character_scene_path = scene_path

# -------------------------
# Berries
# -------------------------
func add_berries(amount: int) -> void:
	berry_count += amount
	_update_hud()
	save_game()

# -------------------------
# Levels
# -------------------------
func unlock_level(level_num: int) -> void:
	if level_num not in unlocked_levels:
		unlocked_levels.append(level_num)
		unlocked_levels.sort()  # Keep sorted
	save_game()

func get_next_level_path() -> String:
	if current_level + 1 in level_scenes:
		return level_scenes[current_level + 1]
	return ""

# -------------------------
# Hats
# -------------------------
func equip_hat(hat_name: String) -> void:
	if hat_name in unlocked_hats:
		current_hat = hat_name
		save_game()

func unlock_hat(hat_name: String) -> void:
	if hat_name not in unlocked_hats:
		unlocked_hats.append(hat_name)
		save_game()

# -------------------------
# HUD Update Helper
# -------------------------
func _update_hud() -> void:
	if get_tree().current_scene:
		var hud = get_tree().current_scene.get_node_or_null("HUD")
		if hud:
			hud.update_berry_count(berry_count)
			hud.update_health(current_health, max_health)

# -------------------------
# Save / Load
# -------------------------
func save_game() -> void:
	var save_data = {
		"berry_count": berry_count,
		"max_health": max_health,
		"current_health": current_health,
		"unlocked_levels": unlocked_levels,
		"current_level": current_level,
		"unlocked_hats": unlocked_hats,
		"current_hat": current_hat,
		"chosen_character_scene_path": chosen_character_scene_path
	}
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data))
	file.close()

func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		print("No save file found. Starting new game.")
		return

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var content: String = file.get_as_text()
	file.close()

	var parse_result = JSON.parse_string(content)
	if parse_result.error != OK:
		print("Error parsing save file:", parse_result.error_string)
		return

	if parse_result.result is Dictionary:
		var data := parse_result.result as Dictionary
		berry_count = data.get("berry_count", 0)
		max_health = data.get("max_health", 5)
		current_health = data.get("current_health", max_health)
		unlocked_levels = data.get("unlocked_levels", [1])
		current_level = data.get("current_level", 1)
		unlocked_hats = data.get("unlocked_hats", [])
		current_hat = data.get("current_hat", "")
		chosen_character_scene_path = data.get("chosen_character_scene_path", "")
	else:
		print("Save file content is not a valid dictionary")
