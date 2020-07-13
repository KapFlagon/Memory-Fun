extends Control


func _ready() -> void:
	get_node("ColorRect").set_frame_color(PlayerData.get_background_colour())
	populate_tables()
	ready_texts()


func populate_tables() -> void:
	var temp_shallow
	var temp_deep
	var temp_name
	var temp_score
	var node_difficulty_easy = "TabContainer/Easy"
	var node_difficulty_medium = "TabContainer/Medium"
	var node_difficulty_hard = "TabContainer/Hard"
	var node_grid_08 = "/Grid_08"
	var node_grid_12 = "/Grid_12"
	var node_grid_16 = "/Grid_16"
	var node_grid_20 = "/Grid_20"
	var node_grid_24 = "/Grid_24"
	var node_first_pos = "/First"
	var node_second_pos = "/Second"
	var node_third_pos = "/Third"
	var node_fourth_pos = "/Fourth"
	var node_fifth_pos = "/Fifth"
	var node_l_name = "/Name"
	var node_l_score = "/Score"
	
	for i_difficulty in range (3):
		var temp_node_path_1
		for grid_size in [8, 12, 16, 20, 24]:
			# Loop iterates 5 times with 'grid_size' as 8, 12, etc.
			if i_difficulty == 0: #easy
				temp_node_path_1 = node_difficulty_easy
				temp_shallow = ScoreManager.dict_easy.get(grid_size)
			elif i_difficulty == 1: #medium
				temp_node_path_1 = node_difficulty_medium
				temp_shallow = ScoreManager.dict_medium.get(grid_size)
			else: #2 hard
				temp_node_path_1 = node_difficulty_hard
				temp_shallow = ScoreManager.dict_hard.get(grid_size)
			var temp_node_path_2
			if grid_size == 8: 
				temp_node_path_2 = temp_node_path_1 + node_grid_08
			elif grid_size == 12:
				temp_node_path_2 = temp_node_path_1 + node_grid_12
			elif grid_size == 16:
				temp_node_path_2 = temp_node_path_1 + node_grid_16
			elif grid_size == 20:
				temp_node_path_2 = temp_node_path_1 + node_grid_20
			else:
				temp_node_path_2 = temp_node_path_1 + node_grid_24
				
			for rank in temp_shallow.size():
				var temp_node_path_3
				temp_deep = temp_shallow[rank]
				temp_name = temp_deep[0]
				temp_score = temp_deep[1]
				temp_score = ScoreManager.secs_to_string(temp_score)
				if rank == 0:
					temp_node_path_3 = temp_node_path_2 + node_first_pos
				elif rank == 1:
					temp_node_path_3 = temp_node_path_2 + node_second_pos
				elif rank == 2:
					temp_node_path_3 = temp_node_path_2 + node_third_pos
				elif rank == 3:
					temp_node_path_3 = temp_node_path_2 + node_fourth_pos
				else:
					temp_node_path_3 = temp_node_path_2 + node_fifth_pos
				var temp_node_name = temp_node_path_3 + node_l_name
				var temp_node_score = temp_node_path_3 + node_l_score
				get_node(temp_node_name).text = temp_name
				get_node(temp_node_score).text = temp_score


func _on_MainMenuButton_button_up() -> void:
	AudioManager.play_rand_sfx()
	get_tree().change_scene("res://src/screens/StartScreen.tscn")


func _on_TabContainer_tab_changed(tab: int) -> void:
	AudioManager.play_rand_sfx()


func ready_texts() -> void:
	$Title.set_text(tr("HIGH_SCORES"))
	$TabContainer.set_tab_title(0, tr("DIFF_EASY"))
	$TabContainer/Easy/Grid_08/Label.set_text(tr("HSS_8"))
	$TabContainer/Easy/Grid_12/Label.set_text(tr("HSS_12"))
	$TabContainer/Easy/Grid_16/Label.set_text(tr("HSS_16"))
	$TabContainer/Easy/Grid_20/Label.set_text(tr("HSS_20"))
	$TabContainer/Easy/Grid_24/Label.set_text(tr("HSS_24"))
	$TabContainer.set_tab_title(1, tr("DIFF_MED"))
	$TabContainer/Medium/Grid_08/Label.set_text(tr("HSS_8"))
	$TabContainer/Medium/Grid_12/Label.set_text(tr("HSS_12"))
	$TabContainer/Medium/Grid_16/Label.set_text(tr("HSS_16"))
	$TabContainer/Medium/Grid_20/Label.set_text(tr("HSS_20"))
	$TabContainer/Medium/Grid_24/Label.set_text(tr("HSS_24"))
	$TabContainer.set_tab_title(2, tr("DIFF_HARD"))
	$TabContainer/Hard/Grid_08/Label.set_text(tr("HSS_8"))
	$TabContainer/Hard/Grid_12/Label.set_text(tr("HSS_12"))
	$TabContainer/Hard/Grid_16/Label.set_text(tr("HSS_16"))
	$TabContainer/Hard/Grid_20/Label.set_text(tr("HSS_20"))
	$TabContainer/Hard/Grid_24/Label.set_text(tr("HSS_24"))
	$MainMenuButton.set_text(tr("MAIN_MENU"))
