extends Node

func _ready():
	if owner:
		owner.speed *= 1.5
