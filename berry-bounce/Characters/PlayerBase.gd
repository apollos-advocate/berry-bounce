extends CharacterBody2D

@export var move_speed: float = 350.0
@export var jump_force: float = -600.0
@export var gravity: float = 2000.0

@export var max_falls: int = 5
@export var max_health: int = 100

var health: int
var fall_count: int = 0
var checkpoint_position: Vector2

@onready var hat_sprite = $HatSprite2D

func _ready():
	health = max_health
	checkpoint_position = global_position
	update_hud()

func _physics_process(delta: float):
	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force

	# Movement
	var direction := Input.get_axis("left", "right")
	if direction != 0:
		velocity.x = direction * move_speed
		$Sprite2D.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)

	move_and_slide()

	# Check for fall
	if global_position.y > 1000:
		handle_fall()

func handle_fall():
	fall_count += 1
	if fall_count > max_falls:
		die()
	else:
		respawn()

func respawn():
	global_position = checkpoint_position
	health -= 1
	update_hud()
	if health <= 0:
		die()

func die():
	Global.save_game()
	get_tree().change_scene("res://UI/gameover.tscn")

func take_damage(amount: int):
	health -= amount
	update_hud()
	if health <= 0:
		die()

func bounce():
	velocity.y = jump_force * 0.5

func set_checkpoint(pos: Vector2):
	checkpoint_position = pos

func update_hud():
	if has_node("/root/Main/HUD"):
		get_node("/root/Main/HUD").update_health(health)
		get_node("/root/Main/HUD").update_berry_count(Global.berry_count)
