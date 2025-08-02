extends CanvasLayer

@export var player_path: NodePath
var player

func _ready():
	player = get_node(player_path)
	update_berry_count(Global.berry_count)
	update_health(player.max_health)

func update_berry_count(amount: int):
	$BerryCountLabel.text = "Berries: %d" % amount

func update_health(health: int):
	$HealthLabel.text = "Health: %d/%d" % [health, player.max_health]
