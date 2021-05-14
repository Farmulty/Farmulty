extends Node2D

func _on_Harvest_pressed():
	$Character.harvest_crop()

func _on_Button_pressed():
	$Character.plant_crop($Character/Menu/CropType.text)
func _process(delta):
	$NPCs/Path2D/PathFollow2D.offset += 15 * delta
