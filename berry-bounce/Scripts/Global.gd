extends Node

# The path to the chosen character scene file
var chosen_character_scene_path: String = ""

# Player berry count
var berry_count: int = 0

# List of unlocked level numbers, starting with level 1 unlocked
var unlocked_levels: Array = [1]

# Currently selected level number
var current_level: int = 1

# Player health (you can adjust or expand this later)
var max_health: int = 100
var current_health: int = max_health

# Hats unlocked and currently equipped 
var unlocked_hats: Array = []
var current_hat: String = ""

# Called when the node enters the scene tree
func _ready():
	# load saved data here
	pass

func set_chosen_character(scene_path: String) -> void:
	chosen_character_scene_path = scene_path

func add_berries(amount: int) -> void:
	berry_count += amount
	# Add save_game() here after implementing saving

func unlock_level(level_num: int) -> void:
	if level_num not in unlocked_levels:
		unlocked_levels.append(level_num)
		unlocked_levels.sort()  # Keep sorted

func equip_hat(hat_name: String) -> void:
	if hat_name in unlocked_hats:
		current_hat = hat_name

func unlock_hat(hat_name: String) -> void:
	if hat_name not in unlocked_hats:
		unlocked_hats.append(hat_name)
