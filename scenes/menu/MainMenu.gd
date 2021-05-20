extends Control

onready var global = get_node("/root/Global")

func _on_Start_pressed():
	global.goto_scene("res://scenes/overworld/Overworld.tscn")

func _on_Quit_pressed():
	get_tree().quit()