extends Node

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

func _ready() -> void:
	# Load saved data here in the future
	pass

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
	# Look for HUD inside the *current* active scene
	if get_tree().current_scene:
		var hud = get_tree().current_scene.get_node_or_null("HUD")
		if hud:
			hud.update_berry_count(berry_count)
			hud.update_health(current_health, max_health)

# -------------------------
# Save / Load (placeholder)
# -------------------------
func save_game() -> void:
	print("Saving game... (placeholder)")
	# Later: Write to file here
