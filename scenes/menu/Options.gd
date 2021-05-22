extends Control

signal close_options

func get_volume(bus_name: String) -> float:
	var idx = AudioServer.get_bus_index(bus_name)
	return AudioServer.get_bus_volume_db(idx)

func change_volume(bus_name: String, value: float):
	var idx = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(idx, value)

func _on_Music_value_changed(value: float):
	change_volume("Music", value)

func _on_Soundeffects_value_changed(value: float):
	change_volume("SFX", value)
	$SFX.play()

func show():
	var global = get_node("/root/Global")

	$Music.value = get_volume("Music")
	$Soundeffects.value = get_volume("SFX")
	visible = true
	global.in_menu = true

func hide():
	var global = get_node("/root/Global")

	global.in_menu = false
	visible = false

func _on_Quit_pressed():
	emit_signal("close_options")
