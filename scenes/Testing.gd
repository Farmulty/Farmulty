extends Node2D

func _on_Button_pressed():
	var carrot = load("res://scenes/plants/Carrot.tscn").instance()
	add_child(carrot)
	var dirt_pos = $Overworld/Base.map_to_world(Vector2(15, 6))
	carrot.position.y = dirt_pos.y + 8
	carrot.position.x = dirt_pos.x + 8
