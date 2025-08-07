extends Control

@onready var berry_label = $MainContainer/ShopVBox/BerryLabel

func _ready() -> void:
	$MainContainer/ShopVBox/CoolHatBox/BuyCoolHatButton.pressed.connect(func() -> void:
		_try_buy("Cool Hat", 8)
	)
	$MainContainer/ShopVBox/TVHatBox/BuyTVHatButton.pressed.connect(func() -> void:
		_try_buy("TV Hat", 6)
	)
	$MainContainer/ShopVBox/SantaHatBox/BuySantaHatButton.pressed.connect(func() -> void:
		_try_buy("Santa Hat", 10)
	)
	$MainContainer/ShopVBox/LeprechaunHatBox/BuyLeprechaunHatButton.pressed.connect(func() -> void:
		_try_buy("Leprechaun Hat", 8)
	)
	$MainContainer/ShopVBox/TopHatBox/BuyTopHatButton.pressed.connect(func() -> void:
		_try_buy("Top Hat", 15)
	)
	$MainContainer/ShopVBox/BrownHatBox/BuyBrownHatButton.pressed.connect(func() -> void:
		_try_buy("Brown Fedora", 4)
	)
	$MainContainer/ShopVBox/BlackHatBox/BuyBlackHatButton.pressed.connect(func() -> void:
		_try_buy("Black Star Fedora", 25)
	)

	update_ui()

func _try_buy(hat_name: String, cost: int) -> void:
	if Global.berry_count >= cost:
		if hat_name not in Global.unlocked_hats:
			Global.berry_count -= cost
			Global.unlock_hat(hat_name)
			update_ui()
			show_message("Bought %s!" % hat_name)
		else:
			show_message("You already own the %s." % hat_name)
	else:
		show_message("Not enough berries to buy %s." % hat_name)

func update_ui() -> void:
	berry_label.text = "Berries: %d" % Global.berry_count

func show_message(text: String) -> void:
	
	print(text)
