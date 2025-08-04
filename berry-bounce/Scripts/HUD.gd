extends CanvasLayer

func update_berry_count(count: int):
	$HBoxContainer/BerryLabel.text = "x %d" % count

func update_health(current: int, max: int):
	$HealthLabel.text = "Health: %d/%d" % [current, max]
