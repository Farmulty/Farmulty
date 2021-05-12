extends Node2D

signal player_in_range

func _on_DetectionArea_body_entered(body):
	if body.get_parent().is_in_group("PlantableArea"):
		# Don't react to plantable areas entering the area
		return
	elif body.get_parent().is_in_group("Players"):
		emit_signal("player_in_range")
		print("Pog")
		