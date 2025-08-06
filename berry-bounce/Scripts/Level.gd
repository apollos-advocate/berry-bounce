extends Node2D

var level_complete_menu
var hud

func _ready():
	# --- Spawn Player ---
	var player_scene_path = Global.chosen_character_scene_path
	if player_scene_path == "":
		player_scene_path = "res://Characters/strawberrychar.tscn"

	var player_scene = load(player_scene_path)
	var player_instance = player_scene.instantiate()
	player_instance.position = $PlayerSpawn.position
	add_child(player_instance)

	# --- Get HUD reference (must exist in scene already) ---
	hud = get_node_or_null("HUD")
	if hud:
		# Initial update so HUD matches current game state
		hud.update_berry_count(Global.berry_count)
		hud.update_health(Global.current_health, Global.max_health)

	# --- Add Level Complete Menu ---
	var level_complete_scene = preload("res://Scenes/LevelComplete.tscn")
	level_complete_menu = level_complete_scene.instantiate()
	level_complete_menu.name = "LevelCompleteMenu"
	add_child(level_complete_menu)
	level_complete_menu.visible = false

func _on_berry_level_1_body_entered(body: Node2D) -> void:
	pass


func _on_berry_level_7_body_entered(body: Node2D) -> void:
	pass 
