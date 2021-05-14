extends Node2D

var held_item

func has_item() -> bool:
	if held_item != null:
		return true
	return false

func update_held_item(item):
	held_item = item

func remove_held_item():
	held_item = null