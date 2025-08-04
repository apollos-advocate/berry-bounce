extends CanvasLayer

func update_berry_count(count: int):
	$HBoxContainer/BerryLabel.text = "x %d" % count

func update_health(current: int, max: int):
	$HBoxContainer/HealthLabel.text = "Health: %d/%d" % [current, max]
