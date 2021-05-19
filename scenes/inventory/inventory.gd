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

		if slot.has_item() and slot.item_equals(item_node) and not slot.item_max():
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

func use_seeds():
	var held_item

	var global = get_node("/root/Global")
	var slot_node = get_node("Slots/Slot" + str(current_slot))

	if slot_node.has_item():
		held_item = slot_node.held_item
	else:
		return

	if held_item.item_name in global.seeds:
		if get_parent().plant_crop(held_item.crop_name):
			slot_node.decrease_item_amount(1)

func slot_is_tool() -> bool:
	var slot_node = get_node("Slots/Slot" + str(current_slot))
	var global = get_node("/root/Global")

	if slot_node.has_item() and slot_node.held_item.item_name in global.tools.keys():
		return true
	else:
		return false

func use_tool():
	var slot_node = get_node("Slots/Slot" + str(current_slot))
	slot_node.held_item.use()

func _physics_process(delta):
	for i in range(1, total_slots + 1): # Go through each slot
		if Input.is_action_just_pressed(str(i)):
			select_slot(i)
	
	if Input.is_action_just_pressed("E"):
		if slot_is_tool():
			use_tool()
		else:
			use_seeds()
