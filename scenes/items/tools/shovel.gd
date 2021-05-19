extends Node2D

export var item_name: String = "Shovel"
export var max_stack: int = 1

enum Facing{
	down,
	up,
	left,
	right
}

func use() -> bool:
	var Overworld = get_node("/root/Overworld")
	var plantable_space: Area2D = Overworld.get_node("Overworld/PlantableSpace")
	var plantable_areas = Overworld.get_node("PlantableAreas")
	var player: Node2D = Overworld.get_node("Character")

	if player.get_node("KinematicBody2D") in plantable_space.get_overlapping_bodies():
		var plantable_area = load("res://scenes/special_area/PlantableArea.tscn").instance()
		var tile_map: TileMap = Overworld.get_node("Overworld/Base")
		var flowers_tiles = Overworld.get_node("Overworld/Flowers")
		var trees: Node2D = Overworld.get_node("Trees")
		var p_position = tile_map.world_to_map(player.current_position)

		match player.get_facing_direction():
			Facing.left:
				p_position += Vector2(-1, 0)
			Facing.right:
				p_position += Vector2(1, 0)

		plantable_area.position = tile_map.map_to_world(p_position) + Vector2(8, 8)
		
		# Check for overlaps
		for area in plantable_areas.get_children():
			if area.position == plantable_area.position: 
				return false

		# Add to scene
		plantable_areas.add_child(plantable_area)

		# Update plant edges
		Overworld.update_plant_edges()
		return true
	return false

export var can_be_picked_up: bool = true
export var can_be_sold: bool = false
export var price_sold: int = 99
