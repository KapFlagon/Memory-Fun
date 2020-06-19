extends Node

var difficulty setget set_difficulty, get_difficulty
var grid_size  setget set_grid_size, get_grid_size
var game_time setget set_game_time, get_game_time
var background_colour setget set_background_colour, get_background_colour
var colour_blind_mode_on setget set_colour_blind_mode_on, get_colour_blind_mode_on


func _ready() -> void:
	initialize()


func initialize() -> void:
	difficulty = 0
	grid_size = 8
	colour_blind_mode_on = false
	background_colour = Color(0.172549,0.545098,0.509804,1)


func set_difficulty(new_difficulty: int) -> void:
	difficulty = new_difficulty


func get_difficulty():
	return difficulty


func set_grid_size(new_grid_size) -> void:
	grid_size = new_grid_size


func get_grid_size():
	return grid_size


func set_game_time(new_game_time) -> void:
	game_time = new_game_time


func get_game_time(): 
	return game_time


func set_background_colour(new_colour: Color) -> void: 
	background_colour = new_colour


func get_background_colour():
	return background_colour


func set_colour_blind_mode_on(val: bool) -> void: 
	colour_blind_mode_on = val


func get_colour_blind_mode_on():
	return colour_blind_mode_on
