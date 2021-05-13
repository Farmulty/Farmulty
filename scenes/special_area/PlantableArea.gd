extends Node2D

signal player_in_range

var crop

func crop_mature():
	add_to_group("MaturePlantArea")
	remove_from_group("GrowingPlantArea")

func reset():
	crop = null

	for group in get_groups():
		remove_from_group(group)
	
	add_to_group("PlantableArea")

	if not $Hole.visible:
		$Hole.show()

func set_crop(s_crop: Node2D):
	crop = s_crop

func _on_DetectionArea_body_entered(body):
	if body.get_parent().is_in_group("PlantableArea"):
		# Don't react to plantable areas entering the area
		return
	elif body.get_parent().is_in_group("Players"):
		emit_signal("player_in_range")
		