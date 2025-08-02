extends Area2D

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "player": # your player's node name
		print("Berry collected!")
		queue_free() # remove berry
