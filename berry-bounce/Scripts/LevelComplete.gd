extends CanvasLayer

func _ready():
	visible = false  # Start hidden

	$VBoxContainer/NextLevelButton.connect("pressed", Callable(self, "_on_next_level_pressed"))
	$VBoxContainer/ReplayLevelButton.connect("pressed", Callable(self, "_on_replay_pressed"))
	$VBoxContainer/LevelSelectButton.connect("pressed", Callable(self, "_on_level_select_pressed"))
	$VBoxContainer/MainMenuButton.connect("pressed", Callable(self, "_on_main_menu_pressed"))

func show_level_complete():
	visible = true
	get_tree().paused = true

func _on_next_level_pressed():
	get_tree().paused = false
	Global.current_level += 1
	get_tree().change_scene_to_file("res://Levels/Level%d.tscn" % Global.current_level)

func _on_replay_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_level_select_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/LevelSelect.tscn")

func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
