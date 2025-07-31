extends Control

func _ready() -> void:
	update_button_states()

func _on_Level1_pressed():
	get_tree().change_scene("res://Level1.tscn")

func _on_Level2_pressed():
	get_tree().change_scene("res://Level2.tscn")

func _on_Level3_pressed():
	get_tree().change_scene("res://Level3.tscn")

func _on_Level4_pressed():
	get_tree().change_scene("res://Level4.tscn")

func _on_Level5_pressed():
	get_tree().change_scene("res://Level5.tscn")

func _on_BackButton_pressed():
	get_tree().change_scene("res://scenes/ui/start_screen.tscn")

func update_button_states():
	var unlocked = SaveSystem.data.unlocked_levels

	$Level1.disabled = false
	$Level2.disabled = unlocked < 2
	$Level3.disabled = unlocked < 3
	$Level4.disabled = unlocked < 4
	$Level5.disabled = unlocked < 5
