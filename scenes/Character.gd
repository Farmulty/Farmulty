extends Node2D

export (int) var speed = 155

var velocity = Vector2()
export var current_position: Vector2 # Keeps track of current global position of the player since positon != the actual position

var plantable_crops = {
	"Carrots": "res://scenes/plants/Carrot.tscn",
	"Wheat": "res://scenes/plants/Wheat.tscn"
}

func plant_crop(crop: String):
	var is_plantable: bool = false
	var area_distance: Dictionary

	# @TODO: It should plant on the area that we're the most in
	var areas = get_tree().get_nodes_in_group("PlantableArea")

	for area in areas:
		if area.get_node("DetectionArea").overlaps_area($KinematicBody2D/HarvestRange) \
			and crop in plantable_crops.keys():
				area_distance[area] = (current_position + Vector2(0, 8)).distance_to(area.position) # Calculate each nodes distance to the player
				# -> Adding 8 to the y makes it consider the base as the foots of the player, feels more natural
				is_plantable = true

	if is_plantable:
		var area

		var sorted_areas: Array = area_distance.values()
		sorted_areas.sort()

		for key in area_distance.keys(): # Find the closest node in the dictionary
			if area_distance[key] == sorted_areas[0]:
				area = key
				break

		var crop_node = load(plantable_crops[crop]).instance()

		get_parent().get_node("Crops").add_child(crop_node)

		crop_node.set_area(area)

		crop_node.position.x = area.position.x
		crop_node.position.y = area.position.y
		area.remove_from_group("PlantableArea") # Area is no longer plantable
		area.add_to_group("GrowingPlantArea")

func get_input():
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
		$KinematicBody2D/AnimatedSprite.play("running")
		
		if velocity.x == -1:
			$KinematicBody2D/AnimatedSprite.flip_h = true
		else:
			$KinematicBody2D/AnimatedSprite.flip_h = false
	else:
		$KinematicBody2D/AnimatedSprite.play("idle")
		
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = $KinematicBody2D.move_and_slide(velocity)
	current_position = position + $KinematicBody2D.position
