extends StaticBody2D

signal is_mature

export var Stage: int
export var creation_date: int

func _ready():
	if creation_date == 0:
		creation_date = OS.get_unix_time()

func _on_Timer_timeout():
	Stage += 1
	
	$AnimatedSprite.frame = Stage
	
	if Stage == 4:
		$AnimatedSprite.hide()
		$Mature.show()
		emit_signal("is_mature")
		$Timer.stop()

func harvest() -> bool:
	if Stage != 5:
		return false
	else:
		return true