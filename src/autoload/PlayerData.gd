extends Node

var difficulty:= 0 setget set_difficulty, get_difficulty
var grid_size := 8 setget set_grid_size, get_grid_size
var game_time setget set_game_time, get_game_time
var background_colour := Color(0.172549,0.545098,0.509804,1) setget set_background_colour, get_background_colour
var game_paused = false setget set_game_paused, get_game_paused
var paused_grid setget set_paused_grid, get_paused_grid
var paused_selector_pos setget set_paused_selector_pos, get_paused_selector_pos
var paused_scene setget set_paused_scene, get_paused_scene


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


func set_game_paused(val: bool) -> void:
	game_paused = val


func get_game_paused():
	return game_paused


func set_paused_grid(val) -> void:
	paused_grid = val
	var cols = val.size()
	var rows = val[0].size()
	for i in cols:
		for j in rows:
			paused_grid[i][j] = val [i][j]
	print("here")


func get_paused_grid():
	return paused_grid


func set_paused_selector_pos(val) -> void:
	paused_selector_pos = val


func get_paused_selector_pos():
	return paused_selector_pos

func set_paused_scene(val) -> void:
	var root = get_tree().get_root()
	paused_scene = root.get_child(root.get_child_count() - 1)


func get_paused_scene(): 
	return paused_scene


func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	call_deferred("_deferred_goto_scene", path)


#func _deferred_goto_scene(path):
#	# It is now safe to remove the current scene
#	current_scene.free()
#
#	# Load the new scene.
#	var s = ResourceLoader.load(path)
#
#	# Instance the new scene.
#	current_scene = s.instance()
#
#	# Add it to the active scene, as child of root.
#	get_tree().get_root().add_child(current_scene)
#
#	# Optionally, to make it compatible with the SceneTree.change_scene() API.
#	get_tree().set_current_scene(current_scene)
