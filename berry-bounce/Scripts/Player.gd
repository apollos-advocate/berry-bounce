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
	current_health = max_health
	checkpoint_position = global_position

	# Make sure player is in Player group
	if not is_in_group("Player"):
		add_to_group("Player")

	_update_hud()

func _physics_process(delta: float):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force

	# Left/right movement
	var direction = Input.get_axis("left", "right")
	if direction != 0:
		velocity.x = direction * move_speed
		$Sprite2D.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)

	move_and_slide()

	# Fall detection
	if global_position.y > 2000:
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
	# Let Global handle finding and updating the HUD
	Global.current_health = current_health
	Global._update_hud()

# --- Respawn / Death ---
func _respawn():
	global_position = checkpoint_position
	current_health -= 1
	_update_hud()
	if current_health <= 0:
		_die()

func _die():
	var game_over_menu = get_tree().current_scene.find_child("GameOverMenu", true, false)
	if game_over_menu:
		game_over_menu.show_game_over()

# --- Checkpoints ---
func set_checkpoint(pos: Vector2):
	checkpoint_position = pos
