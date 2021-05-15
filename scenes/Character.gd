extends Node2D

export (int) var speed = 155

var velocity = Vector2()
export var current_position: Vector2 # Keeps track of current global position of the player since positon != the actual position

var plantable_crops = {
	"Carrots": "res://scenes/plants/Carrot.tscn",
	"Wheat": "res://scenes/plants/Wheat.tscn"
}

func find_closest_node(node: Dictionary) -> Node2D:
	""" Finds the closest Node in dictionary of nodes """
	var sorted_areas: Array = node.values()
	sorted_areas.sort()

	for key in node.keys(): # Find the closest node in the dictionary
		if node[key] == sorted_areas[0]:
			return key
	
	print_debug("Impossible issue")
	return Node2D.new() # Never should be returned
	

func plant_crop(crop: String):
	var is_plantable: bool = false
	var area_distance: Dictionary

	var areas = get_tree().get_nodes_in_group("PlantableArea")

	for area in areas:
		if area.get_node("DetectionArea").overlaps_area($KinematicBody2D/HarvestRange) \
			and crop in plantable_crops.keys():
				area_distance[area] = (current_position + Vector2(0, 8)).distance_to(area.position) # Calculate each nodes distance to the player
				# -> Adding 8 to the y makes it consider the base as the foots of the player, feels more natural
				is_plantable = true

	if is_plantable:
		var area = find_closest_node(area_distance)

		var crop_node = load(plantable_crops[crop]).instance()

		get_parent().get_node("Crops").add_child(crop_node)

		crop_node.set_area(area)
		area.set_crop(crop_node)

		crop_node.position.x = area.position.x
		crop_node.position.y = area.position.y
		area.remove_from_group("PlantableArea") # Area is no longer plantable
		area.add_to_group("GrowingPlantArea")

func harvest_crop():
	var area_distance: Dictionary
	var is_harvestable = false

	var areas = get_tree().get_nodes_in_group("MaturePlantArea")

	for area in areas:
		if area.get_node("DetectionArea").overlaps_area($KinematicBody2D/HarvestRange):
			area_distance[area] = (current_position + Vector2(0, 8)).distance_to(area.position)
			is_harvestable = true
	
	if is_harvestable:
		var area = find_closest_node(area_distance)
		var crop = area.crop
		
		var global = get_node("/root/Global")

		if crop.item in global.allowed_items.keys():
			var pickups = get_parent().get_node("Pickups")
			var pickup = load("res://scenes/items/overworld_pickup.tscn").instance()
			pickups.add_child(pickup)

			var item: Node2D = load(global.allowed_items[crop.item]).instance()
			pickup.add_child(item)

			pickup.position = area.position
			pickup.item = item
		else:
			print("Item wasn't found")

		area.reset()
		crop.queue_free()

func get_movement():
	var vel_factor: float = 1
	velocity = Vector2()

	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
		
	if velocity.y != 0 or velocity.x != 0:		
		if velocity.x == -1:
			$KinematicBody2D/AnimatedSprite.flip_h = true
		else:
			$KinematicBody2D/AnimatedSprite.flip_h = false

		if Input.is_action_pressed("ctrl"):
			vel_factor = 0.5
			$KinematicBody2D/AnimatedSprite.play("walking")
		else:
			$KinematicBody2D/AnimatedSprite.play("running")
	else:
		$KinematicBody2D/AnimatedSprite.play("idle")
		
	velocity = velocity.normalized() * speed * vel_factor
func _physics_process(delta):
	get_movement()
	velocity = $KinematicBody2D.move_and_slide(velocity)
	current_position = position + $KinematicBody2D.position

