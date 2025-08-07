extends Node

func _physics_process(_delta):
	if owner and Input.is_action_pressed("jump") and not owner.is_on_floor():
		owner.velocity.y = min(owner.velocity.y, 100)
