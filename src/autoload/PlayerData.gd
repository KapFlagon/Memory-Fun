extends Node

var difficulty:= 0 setget set_difficulty, get_difficulty
var grid_size := 8 setget set_grid_size, get_grid_size
var game_time setget set_game_time, get_game_time
var background_colour := Color(0.172549,0.545098,0.509804,1) setget set_background_colour, get_background_colour
var music_on := true setget set_music_on, get_music_on
var music_vol := 100 setget set_music_vol, get_music_vol
var sfx_on := true setget set_sfx_on, get_sfx_on
var sfx_vol := 100 setget set_sfx_vol, get_sfx_vol


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


func set_music_on(val: bool) -> void:
	music_on = val


func get_music_on():
	return music_on


func set_music_vol(val) -> void:
	music_vol = val


func get_music_vol():
	return music_vol


func set_sfx_on(val: bool) -> void: 
	sfx_on = val


func get_sfx_on():
	return sfx_on


func set_sfx_vol(val) -> void:
	sfx_vol = val


func get_sfx_vol():
	return sfx_vol
