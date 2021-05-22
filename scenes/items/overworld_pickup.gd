extends Node2D

var item

func _on_PickupRange_body_entered(body):
	if body.get_parent().is_in_group("Players"):
		if body.get_parent().get_node("Inventory").add_item(item.item_name, 1) != 0:
			return
		else:
			queue_free()

func add_item(item_n: String):
	var global = get_node("/root/Global")

	if item_n in global.allowed_items.keys():
		item = load(global.allowed_items[item_n]).instance()
		add_child(item)