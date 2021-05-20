extends Node2D

func _ready():
	pass

func _process(delta):
	var frame = $AnimatedSprite.frame
	$AnimatedSprite/Hair.frame = frame
	$AnimatedSprite/Hand.frame = frame

func _on_dialogue_event(event: String):
	if event == "GAVE_CARROT":
		gave("Carrot")
	elif event == "GAVE_WHEAT":
		gave("Wheat")
	elif event == "BUY_SHOVEL":
		buy_shovel()

func buy_shovel():
	var Overworld = get_node("/root/Overworld")
	var player = Overworld.get_node("Character")
	var inv = player.get_node("Inventory")

	if inv.decrease_item_total("Carrot", 15):
		inv.add_item("Shovel", 1)

func gave(item: String):
	var Overworld = get_node("/root/Overworld")
	var player = Overworld.get_node("Character")
	var inv = player.get_node("Inventory")

	if inv.decrease_item_amount(item):
		inv.add_item(str(item) + " Seed", 3)