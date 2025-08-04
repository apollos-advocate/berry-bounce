extends CanvasLayer

func _ready():
	visible = false 

	$VBoxContainer/RetryButton.connect("pressed", Callable(self, "_on_retry_pressed"))
	$VBoxContainer/LevelSelectButton.connect("pressed", Callable(self, "_on_level_select_pressed"))
	$VBoxContainer/MainMenuButton.connect("pressed", Callable(self, "_on_main_menu_pressed"))
	$VBoxContainer/QuitButton.connect("pressed", Callable(self, "_on_quit_pressed"))

func show_game_over():
	visible = true
	get_tree().paused = true

func _on_retry_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_level_select_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/LevelSelect.tscn")

func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func _on_quit_pressed():
	get_tree().quit()
