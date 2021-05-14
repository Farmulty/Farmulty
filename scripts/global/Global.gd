extends Node

# Scene Data
var current_scene = null

export var allowed_items: Dictionary = {
	"carrot": "res://scenes/items/carrot.gd",
	"dummy": "res://scenes/items/dummy.tscn"
}

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func goto_scene(path):
	call_deferred("_deferred_goto_scene", path) # Make sure the scene isn't running anything

func _deferred_goto_scene(path):
	current_scene.free() # Free old scene
	
	var s = ResourceLoader.load(path) # Load scene into memory
	current_scene = s.instance() # Instance new scene
	
	get_tree().get_root().add_child(current_scene) # Add new scene
	get_tree().set_current_scene(current_scene) # Compatibility
