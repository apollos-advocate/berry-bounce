extends Control

@onready var berry_label = $MainContainer/ShopVBox/BerryLabel
@onready var buy_cool_hat_button = $MainContainer/ShopVBox/CoolHatBox/BuyCoolHatButton

func _ready():
	update_ui()

func update_ui():
	berry_label.text = "Berries: %d" % Global.berry_count

	if "cool_hat" in Global.unlocked_hats:
		buy_cool_hat_button.disabled = true

func _on_BuyCoolHatButton_pressed():
	var cost = 20
	if Global.berry_count >= cost and "cool_hat" not in Global.unlocked_hats:
		Global.berry_count -= cost
		Global.unlock_hat("cool_hat")
		Global.equip_hat("cool_hat")
		update_ui()

func _on_CloseButton_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")  # or wherever you want to go
