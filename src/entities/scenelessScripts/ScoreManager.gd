extends Node


var file_path = "res://saved_scores.save"
var dict_master = {}
var dict_easy = {}
var dict_medium = {}
var dict_hard = {}
# dict_master: Key is difficulty, value is:
	# dict_difficulty: Key is grid number, value is: 
		#array: each index is a score rank, each entry is:
			#array: index 0 is name, index 1 is time


func _ready() -> void:
	var save_game_file = File.new()
	if not save_game_file.file_exists(file_path):
		create_defaults()
		save_scores()
	else:
		load_scores()


func create_defaults() -> void:
	var array_dummy_entry = ["Name", 0]
	var array_dummy_grid = []
	var dict_dummy = {}
	for score_rank in range(5):
	# Iterates from 0 to 4
		array_dummy_grid.append(array_dummy_entry.duplicate())
	
	for grid_size in [8, 12, 16, 20, 24]:
		# Loop iterates 5 times with 'grid_size' as 8, 12, etc.
		dict_dummy[grid_size] = array_dummy_grid.duplicate()
	dict_easy = dict_dummy.duplicate()
	dict_medium = dict_dummy.duplicate()
	dict_hard = dict_dummy.duplicate()
	dict_master[0] = dict_easy
	print("easy mode scores: " + str(dict_easy))
	dict_master[1] = dict_medium
	print("medium mode scores: " + str(dict_medium))
	dict_master[2] = dict_hard
	print("hard mode scores: " + str(dict_hard))


func load_scores():
	var save_game_file = File.new()
	save_game_file.open(file_path, File.READ)
	dict_master = save_game_file.get_var(true)
	dict_easy = dict_master[0]
	print("easy mode scores: " + str(dict_easy))
	dict_medium = dict_master[1]
	print("medium mode scores: " + str(dict_medium))
	dict_hard = dict_master[2]
	print("hard mode scores: " + str(dict_hard))


func save_scores():
	var save_game_file = File.new()
	save_game_file.open(file_path, File.WRITE)
	save_game_file.store_var(dict_master, true)


func new_score(name: String, score: int, difficulty: int, grid_size: int) -> void:
	var new_entry_array = [name, score]
	if difficulty == PlayerData.e_difficulty.EASY:
		print("New score, Easy mode")
		dict_easy.get(grid_size).append(new_entry_array)
		dict_easy.get(grid_size).sort_custom(ScoreSorter, "sort_descending")
		dict_easy.get(grid_size).pop_back()
	elif difficulty == PlayerData.e_difficulty.MEDIUM:
		print("New score, Medium mode")
		dict_medium.get(grid_size).append(new_entry_array)
		dict_medium.get(grid_size).sort_custom(ScoreSorter, "sort_descending")
		dict_medium.get(grid_size).pop_back()
	else: # Hard mode
		print("New score, Hard mode")
		dict_hard.get(grid_size).append(new_entry_array)
		dict_hard.get(grid_size).sort_custom(ScoreSorter, "sort_descending")
		dict_hard.get(grid_size).pop_back()
	save_scores()


class ScoreSorter:
	static func sort_descending(score_entry_a, score_entry_b):
		if score_entry_a[1] > score_entry_b[1]:
			return true
		return false


func secs_to_string(elapsed_time):
	var minutes = elapsed_time / 60
	var seconds = elapsed_time % 60
	var str_elapsed_time = "%02d:%02d" % [minutes, seconds]
	return str_elapsed_time
