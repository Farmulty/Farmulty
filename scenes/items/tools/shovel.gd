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
	var player: Node2D = Overworld.get_node("Character")

	if player.get_node("KinematicBody2D") in plantable_space.get_overlapping_bodies():
		var plantable_area = load("res://scenes/special_area/PlantableArea.tscn").instance()
		Overworld.get_node("PlantableAreas").add_child(plantable_area)
		var tile_map: TileMap = Overworld.get_node("Overworld/Base")
		var positon = tile_map.world_to_map(player.current_position)

		match player.get_facing_direction():
			Facing.down:
				position += Vector2(0, 1)
			Facing.up:
				position += Vector2(0, -1)
			Facing.left:
				position += Vector2(-1, 0)
			Facing.right:
				position += Vector2(1, 0)
		
		plantable_area.position = tile_map.map_to_world(position) + Vector2(8, 8)

		# TODO: Check if the spot is actually free
		return true
	return false

export var can_be_picked_up: bool = true
export var can_be_sold: bool = false
export var price_sold: int = 99
