extends Control  # Or your root UI node type

# Paths to your character scenes
var characters = {
	"Strawberry": "res://Characters/strawberrychar.tscn",
	"Raspberry": "res://Characters/raspberrychar.tscn",
	"Blueberry": "res://Characters/blueberrychar.tscn",
	"Blackberry": "res://Characters/blackberrychar.tscn"
}

var selected_character_name: String = ""

func _ready():
	# Connect button pressed signals with bound character names
	$StrawberryButton.connect("pressed", Callable(self, "_on_character_button_pressed").bind("Strawberry"))
	$RaspberryButton.connect("pressed", Callable(self, "_on_character_button_pressed").bind("Raspberry"))
	$BlueberryButton.connect("pressed", Callable(self, "_on_character_button_pressed").bind("Blueberry"))
	$BlackberryButton.connect("pressed", Callable(self, "_on_character_button_pressed").bind("Blackberry"))
	$ConfirmButton.connect("pressed", Callable(self, "_on_confirm_pressed"))
	
	# Disable Confirm button until a character is selected
	$ConfirmButton.disabled = true

func _on_character_button_pressed(character_name: String) -> void:
	selected_character_name = character_name
	Global.set_chosen_character(characters[character_name])
	$ConfirmButton.disabled = false
	_update_character_selection_ui()

func _update_character_selection_ui() -> void:
	for name in characters.keys():
		var button = get_node(name + "Button") as TextureButton
		if name == selected_character_name:
			button.modulate = Color(1, 0.8, 0.4)  # Highlight color (orange-ish)
		else:
			button.modulate = Color(1, 1, 1)      # Normal color (white)

func _on_confirm_pressed() -> void:
	if selected_character_name != "":
		get_tree().change_scene_to_file("res://Scenes/LevelSelect.tscn")
