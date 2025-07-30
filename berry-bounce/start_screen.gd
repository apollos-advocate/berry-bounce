extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_PlayButton_pressed():
	# Replace with your code to load Level Select or first gameplay scene
	print("Play pressed")


func _on_ShopButton_pressed():
	print("Shop pressed")


func _on_InfoButton_pressed():
	print("Info pressed")


func _on_QuitButton_pressed():
	get_tree().quit()
