extends CharacterBody2D

# --- Player settings ---
const SPEED := 350.0
const JUMP_VELOCITY := -600.0
const GRAVITY := 2000.0

# --- Health & Falls ---
@export var max_health := 5
var health := max_health
@export var max_falls := 5
var fall_count := 0
var checkpoint_position := Vector2.ZERO

func _ready():
	checkpoint_position = global_position
	# Update HUD health at start
	get_node("/root/Main/HUD").update_health(health)

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle movement
	var direction := Input.get_axis("left", "right")
	if direction != 0:
		velocity.x = direction * SPEED
		$Sprite2D.flip_h = direction < 0  # Face movement direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# Detect falling below level (adjust Y threshold)
	if global_position.y > 1000:
		fall_count += 1
		if fall_count > max_falls:
			die()
		else:
			respawn()

func respawn():
	global_position = checkpoint_position
	health -= 1
	get_node("/root/Main/HUD").update_health(health)
	if health <= 0:
		die()

func die():
	print("Player died!")
	get_tree().change_scene("res://Scenes/UI/gameover.tscn")  # Replace with your game over scene

func take_damage(amount: int):
	health -= amount
	get_node("/root/Main/HUD").update_health(health)
	if health <= 0:
		die()

func bounce():
	velocity.y = JUMP_VELOCITY * 0.5

func set_checkpoint(pos: Vector2):
	checkpoint_position = pos
