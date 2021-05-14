extends Node2D

var item


func _on_PickupRange_body_entered(body):
	return

	if body.is_in_group("Players"):
		if body.get_node("Inventory").add_item(item.item_name, 1) != 0:
			return
