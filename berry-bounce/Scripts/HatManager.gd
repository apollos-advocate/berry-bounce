extends Node

# Stores paths to all hat images
const HAT_IMAGES = {
	"Cool Hat": "res://Assets/Hats/hat15.png",
	"TV Hat": "res://Assets/Hats/hat1.png",
	"Santa Hat": "res://Assets/Hats/hat3.png",
	"Leprechaun Hat": "res://Assets/Hats/hat17.png",
	"Top Hat": "res://Assets/Hats/hat19.png",
	"Brown Fedora": "res://Assets/Hats/hat21.png",
	"Black Fedora": "res://Assets/Hats/hat22.png",
}

func get_hat_texture(hat_name: String) -> Texture2D:
	if hat_name in HAT_IMAGES:
		return load(HAT_IMAGES[hat_name])
	return null
