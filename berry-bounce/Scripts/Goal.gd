extends Area2D

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.is_in_group("Player"):
		# Unlock next level
		if Global.current_level + 1 not in Global.unlocked_levels and Global.current_level < 10:
			Global.unlocked_levels.append(Global.current_level + 1)
			Global.save_game()

		# Find the LevelCompleteMenu node and show it
		var menu = get_tree().root.find_child("LevelCompleteMenu", true, false)
		if menu:
			menu.show_level_complete()
