extends Node2D

onready var save = SimpleSave.new()

func _on_Button_pressed():
	$Character.plant_crop("carrots")
func _on_Save_pressed():
	save.save_scene(get_tree(), "res://saves/test.tscn")


func _on_Load_pressed():
	save.load_scene(get_tree(), "res://saves/test.tscn")

func _process(delta):
	$Path2D/PathFollow2D.offset += 15 * delta
