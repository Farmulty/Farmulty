extends StaticBody2D

signal is_mature

export var Stage: int
var creation_date: int

func _ready():
	creation_date = OS.get_unix_time()

func _on_Timer_timeout():
	Stage += 1
	
	$AnimatedSprite.frame = Stage
	
	if Stage == 5:
		emit_signal("is_mature")
		$Timer.stop()

func harvest() -> bool:
	if Stage != 5:
		return false
	else:
		return true