extends Node

var difficulty := 0 setget set_difficulty, get_difficulty
var grid_size := 8 setget set_grid_size, get_grid_size
var game_time setget set_game_time, get_game_time
var background_colour := 0 setget set_background_colour, get_background_colour


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


func set_background_colour(new_colour) -> void: 
	background_colour = new_colour


func get_background_colour():
	return background_colour
