extends CanvasLayer

@export var player_path: NodePath
var player

var berry_count := 0
var dead_goons := 0

func _ready():
	player = get_node(player_path)
	update_berry_count(0)
	update_health(player.health)
	update_dead_goons(0)

func update_berry_count(amount):
	berry_count = amount
	$BerryCountLabel.text = "Berries: %d" % berry_count

func update_health(health):
	$HealthLabel.text = "Health: %d/5" % health

func update_dead_goons(count):
	dead_goons = count
	$DeadGoonsLabel.text = "Goons Defeated: %d" % dead_goons
