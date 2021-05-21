extends Node2D

signal morning
signal late
signal night

signal next_hour
signal day_over

const ingame_hours_total: int = 24 # Starting at 0as

const rl_sec_per_game_hour: int = 12 # Change later on after testing
var rl_sec_per_game_day: int = ingame_hours_total * rl_sec_per_game_hour
var rl_sec_left: int = rl_sec_per_game_day

var current_time: int = 13
var current_hour: int = current_time

const start_of_morning: int = 6 # 06:00
const start_of_late_day: int = 19 # 19:00
const start_of_night: int = 22 # 22:00

var morning_sec: int = start_of_morning * rl_sec_per_game_hour
var late_sec: int = start_of_late_day * rl_sec_per_game_hour
var night_sec: int = start_of_night * rl_sec_per_game_hour

func _on_TimerHours_timeout():
	current_hour += 1

	match current_hour:
		start_of_morning:
			emit_signal("morning")
		start_of_late_day:
			emit_signal("late")
		start_of_night:
			emit_signal("night")
		ingame_hours_total:
			emit_signal("day_over")
			next_day()

func next_day():
	current_hour = 0

func start():
	$TimerHours.wait_time = rl_sec_per_game_hour
	$TimerHours.start()

func get_current_ingame_time() -> float:
	"""Returns the ingame time in ingame hours"""
	return current_hour + (rl_sec_per_game_hour - $TimerHours.time_left) / rl_sec_per_game_hour
