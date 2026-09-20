extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	StuffManager.coin_counter_updated.connect(update_label)


func update_label():
	text = "Coins: "+str(StuffManager.coin_counter) + " / " + str(StuffManager.total_coins)
