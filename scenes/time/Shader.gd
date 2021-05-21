extends CanvasLayer

const transition_time: int = 20
const steps_per_sec: int = 15

onready var time = get_node("/root/Time")

var current_color: Color = day_color # Change if needed

var is_changing: bool

const day_color: Color = Color(1, 1, 1)
const late_color: Color = Color(0.521, 0.380, 0.105)
const night_color: Color = Color(0.27, 0.34, 0.58)

func _ready():
	$Shader.show() # Literally just because I'm annoyed by it in the Overworld scene
	$Shader.get_material().set_shader_param("tint", current_color)

	time.connect("morning", self, "on_morning_cycle")
	time.connect("late", self, "on_late_cycle")
	time.connect("night", self, "on_night_cycle")

func change_light(color: Color):
	var color_from: Color = current_color

	current_color = color # Reset current_color early on to fix potential overlaps when time is too fast

	var step_size: float = 1.0 / (transition_time * steps_per_sec)
	var step: float
	
	var sleep_per_loop: float = (1.0 / steps_per_sec)

	var transcolor: Color

	while step < 1.0:
		step += step_size
		transcolor = color_from.linear_interpolate(color, step)
		$Shader.get_material().set_shader_param("tint", transcolor)

		yield(get_tree().create_timer(sleep_per_loop), "timeout") # Sleep for a few secs

func on_morning_cycle():
	change_light(Color(1, 1, 1))

func on_late_cycle():
	change_light(Color(0.521, 0.380, 0.105))

func on_night_cycle():
	change_light(Color(0.27, 0.34, 0.58))
