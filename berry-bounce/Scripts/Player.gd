extends CharacterBody2D

# --- Movement settings ---
@export var move_speed: float = 350.0
@export var jump_force: float = -600.0
@export var gravity: float = 2000.0

# --- Health settings ---
@export var max_health: int = 5
var current_health: int

# --- Respawn / checkpoint ---
var checkpoint_position: Vector2

func _ready():
	# Start with full health
	current_health = max_health

	# Set initial checkpoint to starting position
	checkpoint_position = global_position

	# Update HUD at start
	_update_hud()

	# Make sure player is in Player group so pickups detect it
	if not is_in_group("Player"):
		add_to_group("Player")


func _physics_process(delta: float):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force

	# Handle left/right movement
	var direction = Input.get_axis("left", "right")
	if direction != 0:
		velocity.x = direction * move_speed
		$Sprite2D.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)

	move_and_slide()

	# Check for falling off level
	if global_position.y > 2000: # adjust if your level is taller/shorter
		_respawn()


# --- Health & Damage ---
func take_damage(amount: int):
	current_health -= amount
	_update_hud()
	if current_health <= 0:
		_die()

func heal(amount: int):
	current_health = min(current_health + amount, max_health)
	_update_hud()


# --- HUD Updates ---
func _update_hud():
	var hud = get_node_or_null("/root/Main/HUD")
	if hud:
		hud.update_health(current_health, max_health)
		hud.update_berry_count(Global.berry_count)


# --- Respawn / Death ---
func _respawn():
	global_position = checkpoint_position
	current_health -= 1
	_update_hud()
	if current_health <= 0:
		_die()

func _die():
	Global.save_game()
	get_tree().change_scene_to_file("res://Scenes/gameover.tscn")


# --- Checkpoints ---
func set_checkpoint(pos: Vector2):
	checkpoint_position = pos
