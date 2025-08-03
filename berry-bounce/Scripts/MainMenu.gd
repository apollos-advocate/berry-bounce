extends Control

func _ready():
	$VBoxContainer/PlayButton.connect("pressed", Callable(self, "_on_play_pressed"))
	$VBoxContainer/ShopButton.connect("pressed", Callable(self, "_on_shop_pressed"))
	$VBoxContainer/InfoButton.connect("pressed", Callable(self, "_on_info_pressed"))
	$VBoxContainer/QuitButton.connect("pressed", Callable(self, "_on_quit_pressed"))

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/CharacterSelect.tscn")

func _on_shop_pressed():
	get_tree().change_scene_to_file("res://scenes/BerryShop.tscn")

func _on_info_pressed():
	get_tree().change_scene_to_file("res://scenes/Info.tscn")

func _on_quit_pressed():
	get_tree().quit()
