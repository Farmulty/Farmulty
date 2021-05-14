extends CanvasLayer

var inventory: Dictionary
var current_slot: int
const total_slots: int = 9

func select_slot(slot_nr: int):
	current_slot = slot_nr - 1
	var selected_slot = get_node("Slots/Slot" + str(current_slot))

	$Slots/SelectedBox.position = selected_slot.get_node("item_box").position

func add_item(item: String, amount: int):
	pass

func _physics_process(delta):
	for i in range(1, total_slots + 1): # Go through each slot
		if Input.is_action_pressed(str(i)):
			select_slot(i)
