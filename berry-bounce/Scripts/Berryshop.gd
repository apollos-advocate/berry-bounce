extends Control

var hats = {
	"Leaf Hat": 20,
	"Top Hat": 50,
	"Baseball Cap": 40
}

func _ready():
	update_ui()

func buy_hat(hat_name: String):
	if Global.berry_count >= hats[hat_name]:
		Global.berry_count -= hats[hat_name]
		Global.unlock_hat(hat_name)
		update_ui()

func equip_hat(hat_name: String):
	Global.equip_hat(hat_name)
	update_ui()

func update_ui():
	$BerryCountLabel.text = "Berries: %d" % Global.berry_count
	# Here you'd also refresh your shop buttons / equipped hat display
