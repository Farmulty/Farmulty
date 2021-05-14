extends Node2D

var held_item
var amount_held: int
func has_item() -> bool:
	if held_item != null:
		return true
	return false

func item_equals(item) -> bool:
	if held_item.item_name == item.item_name:
		return true
	return false

func update_held_item(item):
	get_parent().get_parent().get_node("Items").add_child(item)
	item.position = position
	item.scale = Vector2(4.5, 4.5)
	held_item = item
	amount_held = 1

func increase_item_amount(amount: int) -> int:
	"""Return 0 if it was successful, else the leftover amount"""
	if held_item.max_stack < amount_held + amount:
		print("Maximum amount reached")
		amount_held = held_item.max_stack

		return amount - (held_item.max_stack - amount)

	amount_held += amount
	return 0

func remove_held_item():
	held_item = null
	amount_held = 0
