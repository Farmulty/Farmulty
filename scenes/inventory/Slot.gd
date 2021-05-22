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

func item_name_equals(item: String) -> bool:
	if held_item.item_name == item:
		return true
	return false

func update_held_item(item):
	get_parent().get_parent().get_node("Items").add_child(item)
	item.position = position
	item.scale = Vector2(4.5, 4.5)
	held_item = item
	amount_held = 1
	update_label()

func increase_item_amount(amount: int) -> int:
	"""Return 0 if it was successful, else the leftover amount"""
	var platz: int = held_item.max_stack - amount_held

	if amount - platz >= 0:
		amount_held = held_item.max_stack
		update_label()
		return amount - platz
	elif platz > amount:
		amount_held += amount
		update_label()
		return 0
	return amount

func item_max() -> bool:
	"""Item full"""
	if held_item.max_stack == amount_held:
		return true
	return false

func decrease_item_amount(amount: int) -> bool:
	if amount_held - amount < 0:
		return false
	
	amount_held -= amount
	update_label()

	if amount_held == 0:
		remove_held_item()

	return true

func remove_held_item():
	held_item.queue_free()
	held_item = null
	amount_held = 0
	update_label()

func update_label():
	if amount_held == 0:
		$item_count.hide()
		$item_name.hide()
	else:
		if not $item_count.visible:
			$item_count.show()
			$item_name.show()
		
		$item_count.text = str(amount_held)
		$item_name.text = held_item.item_name
		
