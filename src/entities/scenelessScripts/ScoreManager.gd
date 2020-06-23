extends Node


# three data structures, each containing a grid, each containing five best times. 
# Dictionaries will not work here, as they must be unique keys. Use arrays instead. 
var array_easy = []
var array_medium = []
var array_hard = []


func _ready() -> void:
	create_defaults()


func create_defaults() -> void:
	for i in 3: # 3 difficulties
		print("i: " + str(i))
		for j in 5: # 5 grids 
			if j == 0: # 8 grid
				push_dummies(j)
			elif j == 1: # 12 grid
				push_dummies(j)
			elif j == 2: # 16 grid
				push_dummies(j)
			elif j == 3: # 20 grid
				push_dummies(j)
			else: # 24 grid
				push_dummies(j)


func push_dummies(pos: int) -> void:
	var dict_dummy = {
		"Name 1" : 0,
		"Name 2" : 0,
		"Name 3" : 0,
		"Name 4" : 0,
		"Name 5" : 0
		}
	array_easy.append(dict_dummy.duplicate())
	array_medium.append(dict_dummy.duplicate())
	array_hard.append(dict_dummy.duplicate())


func load_scores():
	pass


func save_score():
	pass


func compare_scores(grid: int, score: int):
	var temp_dict
	var difficulty = PlayerData.get_difficulty()
	if difficulty == PlayerData.e_difficulty.EASY:
		temp_dict = array_easy[grid].dupicate()
	elif difficulty == PlayerData.e_difficulty.MEDIUM:
		temp_dict = array_medium[grid].dupicate()
	else: # Hard mode
		temp_dict = array_hard[grid].dupicate()
	
	var valid_score = false
	for key in temp_dict: 
		if temp_dict
	


func new_score(name: String, score: int) -> void:
	var grid = find_correct_grid()
	var difficulty = PlayerData.get_difficulty()
	if difficulty == PlayerData.e_difficulty.EASY:
		pass
	elif difficulty == PlayerData.e_difficulty.MEDIUM:
		pass
	else: # Hard mode
		pass


func find_correct_grid():
	var grid = PlayerData.get_grid_size()
	if grid == 8:
		return 0
	elif grid == 12:
		return 1
	elif grid == 16:
		return 2
	elif grid == 20: 
		return 3
	else: # 24 size grid
		return 4
