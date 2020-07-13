extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("ColorRect").set_frame_color(PlayerData.get_background_colour())
	ready_texts()
	for button in get_tree().get_nodes_in_group("DifficultyGroup"):
		button.connect("button_up", self, "_difficulty_button_pressed", [button])
	set_tooltip_texts()


func _on_BackButton_button_up() -> void:
	AudioManager.play_rand_sfx()
	get_tree().change_scene("res://src/screens/StartScreen.tscn")


func next_scene() -> void:
	get_tree().change_scene("res://src/screens/GridSelectionScreen.tscn")


func _difficulty_button_pressed(button):
	AudioManager.play_rand_sfx()
	if button.name == "EasyDifButton":
		PlayerData.set_difficulty(PlayerData.e_difficulty.EASY) 
	elif button.name == "MedDifButton":
		PlayerData.set_difficulty(PlayerData.e_difficulty.MEDIUM)
	else:
		PlayerData.set_difficulty(PlayerData.e_difficulty.HARD)
	next_scene()


func set_tooltip_texts() -> void:
	if PlayerData.get_colour_blind_mode_on():
		get_node("VBox_DifficultySelection/EasyDifButton").set_tooltip(tr("DIFF_EASY_HINT_CB"))
		get_node("VBox_DifficultySelection/MedDifButton").set_tooltip(tr("DIFF_MED_HINT_CB"))
		get_node("VBox_DifficultySelection/HardDifButton").set_tooltip(tr("DIFF_HARD_HINT_CB"))
	else:
		get_node("VBox_DifficultySelection/EasyDifButton").set_tooltip(tr("DIFF_EASY_HINT_COL"))
		get_node("VBox_DifficultySelection/MedDifButton").set_tooltip(tr("DIFF_MED_HINT_COL"))
		get_node("VBox_DifficultySelection/HardDifButton").set_tooltip(tr("DIFF_HARD_HINT_COL"))


func ready_texts() -> void:
	$VBox_DifficultySelection/DifficultyPrompt.set_text(tr("DIFF_PROMPT")+":")
	$VBox_DifficultySelection/EasyDifButton.set_text(tr("DIFF_EASY"))
	$VBox_DifficultySelection/MedDifButton.set_text(tr("DIFF_MED"))
	$VBox_DifficultySelection/HardDifButton.set_text(tr("DIFF_HARD"))
	$VBox_DifficultySelection/BackButton.set_text(tr("BACK"))
