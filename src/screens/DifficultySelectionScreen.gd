extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("ColorRect").set_frame_color(PlayerData.get_background_colour())
	for button in get_tree().get_nodes_in_group("DifficultyGroup"):
		button.connect("button_up", self, "_difficulty_button_pressed", [button])
	set_tooltip_texts()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


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
		get_node("VBox_DifficultySelection/EasyDifButton").set_tooltip("3 Shapes, 1 Background Icon")
		get_node("VBox_DifficultySelection/MedDifButton").set_tooltip("5 Shapes, 3 Background Icons")
		get_node("VBox_DifficultySelection/HardDifButton").set_tooltip("5 Shapes, 7 Background Icons")
	else:
		get_node("VBox_DifficultySelection/EasyDifButton").set_tooltip("3 Shapes, 1 Colour")
		get_node("VBox_DifficultySelection/MedDifButton").set_tooltip("5 Shapes, 3 Colours")
		get_node("VBox_DifficultySelection/HardDifButton").set_tooltip("5 Shapes, 7 Colours")
