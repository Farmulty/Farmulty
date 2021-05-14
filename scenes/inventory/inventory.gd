extends CanvasLayer

const total_slots: int = 9

var inventory: Dictionary
var current_slot: int

var allowed_items: Dictionary = {
	"carrot": "res://scenes/items/carrot.gd",
	"dummy": "res://scenes/items/dummy.tscn"
}

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

func add_item(item: String, amount: int) -> bool:
	if not item in allowed_items.keys():
		print("Illegal item")
		return false
	
	var item_node = load(allowed_items[item])
	var slot = get_first_empty_slot()

	if slot == null:
		print("No empty slot found")
		return false

	slot.update_held_item(item_node)
	return true
	
func _physics_process(delta):
	for i in range(1, total_slots + 1): # Go through each slot
		if Input.is_action_pressed(str(i)):
			select_slot(i)
