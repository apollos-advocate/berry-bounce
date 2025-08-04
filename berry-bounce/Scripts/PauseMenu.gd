extends CanvasLayer

func _ready():
	visible = false  # start hidden
	get_tree().paused = false

	$VBoxContainer/ResumeButton.connect("pressed", Callable(self, "_on_resume_pressed"))
	$VBoxContainer/RestartButton.connect("pressed", Callable(self, "_on_restart_pressed"))
	$VBoxContainer/LevelSelectButton.connect("pressed", Callable(self, "_on_level_select_pressed"))
	$VBoxContainer/MainMenuButton.connect("pressed", Callable(self, "_on_main_menu_pressed"))
	$VBoxContainer/QuitGameButton.connect("pressed", Callable(self, "_on_quit_pressed"))

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		_toggle_pause()

func _toggle_pause():
	visible = not visible
	get_tree().paused = visible  # Pauses/unpauses the game

func _on_resume_pressed():
	_toggle_pause()

func _on_restart_pressed():
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
