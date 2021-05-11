extends Control

onready var global = get_node("/root/Global")

func _on_Start_pressed():
	global.goto_scene("res://scenes/Testing.tscn")