extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "player":  # Capitalize "Player" exactly like your node's name
		print("Goal reached!")
		# Add your level change or message code here
