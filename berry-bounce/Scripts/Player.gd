extends CharacterBody2D

# --- Movement Settings ---
@export var move_speed: float = 350.0
@export var jump_force: float = -600.0
@export var gravity: float = 2000.0

# --- Health ---
@export var max_health: int = 5
var current_health: int

# --- Checkpoint ---
var checkpoint_position: Vector2

func _ready() -> void:
	current_health = max_health
	checkpoint_position = global_position

	if not is_in_group("Player"):
		add_to_group("Player")

	_update_hud()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force

	var direction = Input.get_axis("left", "right")
	if direction != 0:
		velocity.x = direction * move_speed
		$Sprite2D.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed * delta)

	move_and_slide()

	if global_position.y > 2000:
		_respawn()

# --- Health ---
func take_damage(amount: int) -> void:
	current_health -= amount
	_update_hud()
	if current_health <= 0:
		_die()

func heal(amount: int) -> void:
	current_health = min(current_health + amount, max_health)
	_update_hud()

# --- HUD ---
func _update_hud() -> void:
	Global.current_health = current_health
	Global._update_hud()

# --- Respawn / Death ---
func _respawn() -> void:
	global_position = checkpoint_position
	current_health -= 1
	_update_hud()
	if current_health <= 0:
		_die()

func _die() -> void:
	var game_over_menu = get_tree().current_scene.find_child("GameOverMenu", true, false)
	if game_over_menu:
		game_over_menu.show_game_over()

# --- Checkpoints ---
func set_checkpoint(pos: Vector2) -> void:
	checkpoint_position = pos
