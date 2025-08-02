extends CharacterBody2D

@export var speed: float = 50.0
var direction: int = -1  # -1 = left, 1 = right
const GRAVITY := 2000.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	velocity.x = direction * speed
	move_and_slide()

	# Turn around if hitting wall
	if is_on_wall():
		turn_around()

	# Turn around if about to walk off edge
	if not $FloorRay.is_colliding():
		turn_around()

func turn_around():
	direction *= -1
	$Sprite2D.flip_h = direction < 0

func _on_Hurtbox_body_entered(body):
	if body.name == "player":
		if body.global_position.y < global_position.y - 10:
			# Player stomped enemy
			body.bounce()
			die()
		else:
			body.take_damage(1)

func die():
	var hud = get_node("/root/Main/HUD")
	hud.update_dead_goons(hud.dead_goons + 1)
	queue_free()
