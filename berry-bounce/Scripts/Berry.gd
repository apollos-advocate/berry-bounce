extends Area2D

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		Global.add_berries(1)

		
		var hud = get_tree().current_scene.get_node_or_null("HUD")
		if hud:
			hud.update_berry_count(Global.berry_count)

		queue_free()
