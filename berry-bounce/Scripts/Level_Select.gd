extends Control

const MAX_LEVELS = 10

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

func _ready():
	setup_level_buttons()

	# Connect the BackButton signal
	$BackButton.connect("pressed", Callable(self, "_on_back_pressed"))

func setup_level_buttons():
	for level_num in range(1, MAX_LEVELS + 1):
		var button_name = "LevelButton_%d" % level_num
		var button = $LevelsContainer.get_node(button_name) as Button

		if level_num in Global.unlocked_levels:
			button.disabled = false
			button.text = "Level %d" % level_num

			var callable = Callable(self, "_on_level_button_pressed").bind(level_num)
			if not button.is_connected("pressed", callable):
				button.connect("pressed", callable)
		else:
			button.disabled = true
			button.text = "Level %d 🔒" % level_num

func _on_level_button_pressed(level_num: int):
	Global.current_level = level_num
	get_tree().change_scene_to_file(level_scenes[level_num])

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
