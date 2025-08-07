extends Node2D

func _physics_process(_delta):
	if not owner:
		return
	for berry in get_tree().get_nodes_in_group("berries"):
		if owner.global_position.distance_to(berry.global_position) < 100:
			var dir = (owner.global_position - berry.global_position).normalized()
			berry.position += dir * 100 * _delta
