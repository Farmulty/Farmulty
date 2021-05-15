extends CanvasLayer

onready var time = get_node("/root/Time")

func _ready():
	time.connect("morning", self, "on_morning_cycle")
	time.connect("late", self, "on_late_cycle")
	time.connect("night", self, "on_night_cycle")

func change_light(color: Color):
	$Shader.get_material().set_shader_param("tint", color)

func on_morning_cycle():
	change_light(Color(1, 1, 1))

func on_late_cycle():
	change_light(Color(0.521, 0.380, 0.105))

func on_night_cycle():
	change_light(Color(0.27, 0.34, 0.58))
