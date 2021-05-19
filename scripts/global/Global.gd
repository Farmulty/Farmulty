extends Node

# Scene Data
var current_scene = null

var in_dialog: bool

export var seeds: Dictionary = {
	"Carrot Seed": "res://scenes/items/seeds/carrot_seed.tscn",
	"Wheat Seed": "res://scenes/items/seeds/wheat_seed.tscn",
	"Dummy Seed": "res://scenes/items/seeds/dummy_seed.tscn"
}

export var crops: Dictionary = {
	"Carrot": "res://scenes/items/carrot.tscn",
	"Wheat": "res://scenes/items/wheat.tscn",
	"Dummy": "res://scenes/items/dummy.tscn"
}

export var tools: Dictionary = {
	"Shovel": "res://scenes/items/tools/shovel.tscn"
}

export var allowed_items: Dictionary

func combine_two_dicts(dict1: Dictionary, dict2: Dictionary) -> Dictionary:
	"""There is no native append in GDScript
	=> dict1 into dict2
	"""
	for key in dict1.keys():
		dict2[key] = dict1[key]

	return dict2

func combine_array_of_dicts(dict_array: Array) -> Dictionary:
	var result: Dictionary

	for dict in dict_array:
		result = combine_two_dicts(dict, result)

	return result

func _ready():
	var dialogueManager = get_tree().get_root().get_node("DialogueManager")
	# Get Scene Switching data
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

	# Get all legal items
	allowed_items = combine_array_of_dicts([seeds, crops, tools])

	# Connect dialogmanager
	dialogueManager.connect("dialogue_started", self, "dialog_started")
	dialogueManager.connect("dialogue_canceled", self, "dialog_stopped")
	dialogueManager.connect("dialogue_ended", self, "dialog_stopped")

func dialog_started(dialog):
	in_dialog = true

func dialog_stopped(dialog):
	in_dialog = false

func goto_scene(path):
	call_deferred("_deferred_goto_scene", path) # Make sure the scene isn't running anything

func _deferred_goto_scene(path):
	current_scene.free() # Free old scene
	
	var s = ResourceLoader.load(path) # Load scene into memory
	current_scene = s.instance() # Instance new scene
	
	get_tree().get_root().add_child(current_scene) # Add new scene
	get_tree().set_current_scene(current_scene) # Compatibility
