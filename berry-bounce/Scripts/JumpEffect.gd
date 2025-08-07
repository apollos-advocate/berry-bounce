extends Node

func _ready():
	if owner:
		owner.max_jumps = 2
