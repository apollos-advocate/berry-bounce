extends Area2D

func _on_Berry_body_entered(body):
	if body.is_in_group("Strawberrychar"):
		Global.add_berries(1)
		if has_node("/root/Scenes/UI/HUD"):
			get_node("/root/Scenes/UI/HUD").update_berry_count(Global.berry_count)
		queue_free()
