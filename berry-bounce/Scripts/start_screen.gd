extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_PlayButton_pressed():
	get_tree().change_scene("res://Scenes/ui/level_select.tscn")

func _on_ShopButton_pressed():
	get_tree().change_scene("res://Scenes/Shop/shop_screen.tscn")

func _on_InfoButton_pressed():
	get_tree().change_scene("res://Scenes/Info/info_page.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()
