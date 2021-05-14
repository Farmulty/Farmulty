extends CanvasLayer

const total_slots: int = 9

var inventory: Dictionary
var current_slot: int

func select_slot(slot_nr: int):
	current_slot = slot_nr - 1
	var selected_slot = get_node("Slots/Slot" + str(current_slot))

	$Slots/SelectedBox.position = selected_slot.position

func get_first_empty_slot() -> Node2D:
	for i in range(total_slots):
		var slot = get_node("Slots/Slot" + str(i))

		if slot.held_item == null:
			return slot
	return null

func add_item(item: String, amount: int) -> int:
	var global = get_node("/root/Global")

	if not item in global.allowed_items.keys():
		print("Illegal item")
		return amount
	
	var item_node = load(global.allowed_items[item]).instance()

	for i in range(total_slots): # Find if we already have the item somewhere and enough capacity for it in those slots
		var slot = get_node("Slots/Slot" + str(i))

		if slot.item_equals(item_node):
			var leftover = slot.increase_item_amount(amount)

			if leftover != 0:
				add_item(item, leftover) # Recursion, lets go - I bet this will cause some weird problem one day :)
			else:
				return 0

	var slot = get_first_empty_slot()

	if slot == null:
		print("No empty slot found")
		return amount

	slot.update_held_item(item_node)
	return 0
	
func _physics_process(delta):
	for i in range(1, total_slots + 1): # Go through each slot
		if Input.is_action_pressed(str(i)):
			select_slot(i)
