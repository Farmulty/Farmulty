extends Area2D

var dialog: Dictionary

onready var global = get_node("/root/Global")

signal chosen_option(option)
func _process(delta):
	if Input.is_action_just_pressed("E") \
		and overlaps_body(global.player_physics_body):

		if not global.dialog_started:
			global.dialog_node.parse(dialog)
			var data = yield(global.dialog_node, "button")

			emit_signal("chosen_option", int(data[0]))
		else:
			global.in_dialog = false
			global.dialog_started = false
	elif Input.is_action_just_pressed("escape") and global.dialog_started:
		global.in_dialog = false
		global.dialog_started = false
