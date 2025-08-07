extends Node

# Paths to hat images
const HAT_IMAGES := {
	"Cool Hat": "res://Assets/Hats/hat15.png",
	"TV Hat": "res://Assets/Hats/hat1.png",
	"Santa Hat": "res://Assets/Hats/hat3.png",
	"Leprechaun Hat": "res://Assets/Hats/hat17.png",
	"Top Hat": "res://Assets/Hats/hat19.png",
	"Brown Fedora": "res://Assets/Hats/hat21.png",
	"Black Star Fedora": "res://Assets/Hats/hat22.png",
}

var owned_hats: Array[String] = []
var equipped_hat: String = ""
var active_effects: Array[String] = []

func _ready() -> void:
	load_hat_data()

func buy_hat(hat_name: String) -> void:
	if not owned_hats.has(hat_name):
		owned_hats.append(hat_name)
		save_hat_data()

func equip_hat(hat_name: String) -> void:
	if owned_hats.has(hat_name):
		equipped_hat = hat_name
		_apply_effect(hat_name)
		save_hat_data()

func _apply_effect(hat_name: String) -> void:
	active_effects.clear()

	match hat_name:
		"Cool Hat":
			active_effects.append("double_jump")
		"TV Hat":
			active_effects.append("speed_boost")
		"Santa Hat":
			active_effects.append("extra_jump_height")
		"Leprechaun Hat":
			active_effects.append("faster_fall")
		# Add more hat effects here if needed
		_:
			pass

func save_hat_data() -> void:
	var save_data := {
		"owned_hats": owned_hats,
		"equipped_hat": equipped_hat,
	}
	var file := FileAccess.open("user://hat_data.save", FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(save_data))
		file.close()

func load_hat_data() -> void:
	if FileAccess.file_exists("user://hat_data.save"):
		var file := FileAccess.open("user://hat_data.save", FileAccess.READ)
		if file:
			var content: String = file.get_as_text()
			var parsed = JSON.parse_string(content)
			if parsed.error == OK and parsed.result is Dictionary:
				var dict := parsed.result as Dictionary
				owned_hats = dict.get("owned_hats", [])
				equipped_hat = dict.get("equipped_hat", "")
				_apply_effect(equipped_hat)
			file.close()
