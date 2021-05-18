extends Node2D

onready var time = get_node("/root/Time")

func _on_Harvest_pressed():
	$Character.harvest_crop()

func _on_Load_pressed():
	$Character/Inventory.add_item("Carrot Seed", 1)

func _on_Save_pressed():
	$Character/Inventory.add_item("Shovel", 1)

func _on_Button_pressed():
	$Character.plant_crop($Character/Menu/CropType.text)
func _process(delta):
	$NPCs/Path2D/PathFollow2D.offset += 15 * delta

func update_plant_edges():
	var tilemap = get_node("Overworld/PlantEdges")

	for cell in tilemap.get_used_cells():
		tilemap.set_cellv(cell, -1)

	var areas = get_node("PlantableAreas")
	for area in areas.get_children(): # Add edges to 3x3 tile with area in center
		var at_pos = tilemap.world_to_map(area.position)

		for x in [-1, 0, 1]: # Honestly looked cleaner than range(-1, 2)
			for y in [-1, 0, 1]:
				tilemap.set_cell(at_pos.x + x, at_pos.y + y, 1)
	
	tilemap.update_bitmask_region()

func _ready():
	time.start()
	update_plant_edges()
