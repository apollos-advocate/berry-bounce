extends CanvasLayer

@export var player_path: NodePath
var player

func _ready():
	player = get_node_or_null(player_path)
	if player:
		update_berry_count(Global.berry_count)
		update_health(player.health)

func update_berry_count(amount: int):
	$HBoxContainer/BerryCount.text = "Berries: %d" % amount

func update_health(health: int):
	if player:
		$HBoxContainer/Health.text = "Health: %d/%d" % [health, player.max_health]
