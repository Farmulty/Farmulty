extends StaticBody2D

signal is_mature

export var Stage: int
export var creation_date: int

var area: Node2D

func _ready():
	if creation_date == 0:
		creation_date = OS.get_unix_time()

func set_area(s_area):
	area = s_area

func _on_Timer_timeout():
	Stage += 1
	
	$AnimatedSprite.frame = Stage
	
	if Stage == 4:
		$AnimatedSprite.hide()
		$Mature.show()
		area.add_to_group("MaturePlantArea")
		area.remove_from_group("GrowingPlantArea")
		emit_signal("is_mature")
		$Timer.stop()

func harvestable() -> bool:
	if Stage != 5:
		return false
	else:
		return true