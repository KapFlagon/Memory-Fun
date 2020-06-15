extends Node

var difficulty setget set_difficulty, get_difficulty
var grid_size  setget set_grid_size, get_grid_size
var game_time setget set_game_time, get_game_time
var background_colour setget set_background_colour, get_background_colour
#var buffered_colour setget set_buffered_colour, get_buffered_colour
var colour_blind_mode_on setget set_colour_blind_mode_on, get_colour_blind_mode_on


func _ready() -> void:
	initialize()


func initialize() -> void:
	difficulty = 0
	grid_size = 8
	colour_blind_mode_on = false
	#buffered_colour == null
	background_colour = Color(0.172549,0.545098,0.509804,1)
	#update_background_colour()


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
	#buffered_colour = new_colour


func get_background_colour():
	return background_colour


#func set_buffered_colour(val) -> void: 
#	buffered_colour = val
#
#
#func get_buffered_colour():
#	return buffered_colour


func set_colour_blind_mode_on(val: bool) -> void: 
	colour_blind_mode_on = val
	#update_background_colour()


func get_colour_blind_mode_on():
	return colour_blind_mode_on


#func update_background_colour() -> void:
#	if colour_blind_mode_on:
#		background_colour = Color(0.83,0.07,0.35,1)
#	else:
#		if buffered_colour == null:
#			background_colour = Color(0.172549,0.545098,0.509804,1)
#		else: 
#			background_colour = buffered_colour
