extends Node


enum e_difficulty {EASY, MEDIUM, HARD}


var difficulty setget set_difficulty, get_difficulty
var grid_size  setget set_grid_size, get_grid_size
var game_time_secs setget set_game_time_secs, get_game_time_secs
var background_colour setget set_background_colour, get_background_colour
var colour_blind_mode_on setget set_colour_blind_mode_on, get_colour_blind_mode_on
var card_back setget set_card_back, get_card_back


func _ready() -> void:
	initialize()


func initialize() -> void:
	difficulty = 0
	grid_size = 8
	colour_blind_mode_on = false
	background_colour = Color(0.172549,0.545098,0.509804,1)
	set_card_back(0)


func set_difficulty(new_difficulty: int) -> void:
	difficulty = new_difficulty


func get_difficulty():
	return difficulty


func set_grid_size(new_grid_size) -> void:
	grid_size = new_grid_size


func get_grid_size():
	return grid_size


func get_game_time_str():
	var game_time_str = secs_to_string(game_time_secs)
	return game_time_str


func set_game_time_secs(val) -> void:
	game_time_secs = val


func get_game_time_secs():
	return game_time_secs


func set_background_colour(new_colour: Color) -> void: 
	background_colour = new_colour


func get_background_colour():
	return background_colour


func set_colour_blind_mode_on(val: bool) -> void: 
	colour_blind_mode_on = val


func get_colour_blind_mode_on():
	return colour_blind_mode_on


func set_card_back(val) -> void:
	card_back = val


func get_card_back(): 
	return card_back


func secs_to_string(elapsed_time):
	var minutes = elapsed_time / 60
	var seconds = elapsed_time % 60
	var str_elapsed_time = "%02d:%02d" % [minutes, seconds]
	return str_elapsed_time


func reset_defaults() -> void:
	set_background_colour(Color(0.172549,0.545098,0.509804,1))
	set_colour_blind_mode_on(false)
	set_card_back(0)
