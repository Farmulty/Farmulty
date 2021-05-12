extends Node2D

func _on_Button_pressed():
	$Character.plant_crop("carrots")
func _process(delta):
	$Path2D/PathFollow2D.offset += 15 * delta
