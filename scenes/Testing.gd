extends Node2D

onready var save = SimpleSave.new()

func _on_Button_pressed():
	var carrot = load("res://scenes/plants/Carrot.tscn").instance()
	add_child(carrot)
	var dirt_pos = $Overworld/Base.map_to_world(Vector2(15, 6))
	carrot.position.y = dirt_pos.y + 8
	carrot.position.x = dirt_pos.x + 8

func _on_Save_pressed():
	save.save_scene(get_tree(), "res://saves/test.tscn")


func _on_Load_pressed():
	save.load_scene(get_tree(), "res://saves/test.tscn")

func _process(delta):
	$Path2D/PathFollow2D.offset += 15 * delta