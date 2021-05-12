extends Node2D

export (int) var speed = 200

var velocity = Vector2()

var plantable_crops = {
	"carrots": "res://scenes/plants/Carrot.tscn"
}

func plant_crop(crop: String):
	# @TODO: It should plant on the area that we're the most in
	var areas = get_tree().get_nodes_in_group("PlantableArea")

	for area in areas:
		if area.get_node("DetectionArea").overlaps_area($KinematicBody2D/HarvestRange) \
			and crop in plantable_crops.keys():
				var crop_node = load(plantable_crops[crop]).instance()
				get_tree().get_root().add_child(crop_node)
				crop_node.position.x = area.position.x
				crop_node.position.y = area.position.y
				area.remove_from_group("PlantableArea") # Area is no longer plantable
				area.add_to_group("GrowingPlantArea")
				return

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
