extends Node2D

signal morning
signal late
signal night

signal next_hour
signal day_over

const ingame_hours_total: int = 24 # Starting at 0as

const rl_sec_per_game_hour: int = 10 # Change later on after testing
var rl_sec_per_game_day: int = ingame_hours_total * rl_sec_per_game_hour
var rl_sec_left: int = rl_sec_per_game_day

var current_time: int = 5
var current_hour: int = current_time

const start_of_morning: int = 6 # 06:00
const start_of_late_day: int = 19 # 19:00
const start_of_night: int = 22 # 22:00

var morning_sec: int = start_of_morning * rl_sec_per_game_hour
var late_sec: int = start_of_late_day * rl_sec_per_game_hour
var night_sec: int = start_of_night * rl_sec_per_game_hour

func _on_TimerHours_timeout():
	current_hour += 1

	if current_hour == start_of_morning:
		emit_signal("morning")
	elif current_hour == start_of_late_day:
		emit_signal("late")
	elif current_hour == start_of_night:
		emit_signal("night")

func _on_TimerTotal_timeout():
	current_hour = 0
	current_time = 0

	$TimerTotal.wait_time = rl_sec_per_game_day

	emit_signal("day_over")

func _ready():
	$TimerHours.wait_time = rl_sec_per_game_hour
	$TimerTotal.wait_time = rl_sec_per_game_day - (current_time * rl_sec_per_game_hour)

func start():
	$TimerHours.start()
	$TimerTotal.start()

func get_time_left() -> int:
	return $TimerTotal.time_left

func get_time_so_far() -> int:
	return (rl_sec_per_game_day - $TimerTotal.time_left)

func get_current_ingame_time() -> float:
	"""Returns the ingame time in ingame hours"""
	return (rl_sec_per_game_day - $TimerTotal.time_left) / rl_sec_per_game_hour
