extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("ColorRect").set_frame_color(PlayerData.get_background_colour())
	ready_texts()
	for button in get_tree().get_nodes_in_group("GridSelectGroup"):
		button.connect("button_up", self, "_grid_button_pressed", [button]) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_BackButton_button_up() -> void:
	AudioManager.play_rand_sfx()
	get_tree().change_scene("res://src/screens/DifficultySelectionScreen.tscn")


func _grid_button_pressed(button):
	AudioManager.play_rand_sfx()
	if button.name == "8TileGridButton":
		PlayerData.set_grid_size(8)
	elif button.name == "12TileGridButton":
		PlayerData.set_grid_size(12)
	elif button.name == "16TileGridButton":
		PlayerData.set_grid_size(16)
	elif button.name == "20TileGridButton":
		PlayerData.set_grid_size(20)
	elif button.name == "24TileGridButton":
		PlayerData.set_grid_size(24)
	else:
		print("custom")
		pass
		# New scene for specifying custom grid
	next_scene()


func next_scene() -> void:
	get_tree().change_scene("res://src/screens/GameScreen.tscn")


func _on_MainMenu_button_up() -> void:
	AudioManager.play_rand_sfx()
	get_tree().change_scene("res://src/screens/StartScreen.tscn")


func ready_texts() -> void:
	$VBox_GridSelection/GridPrompt.set_text(tr("GRID_PROMPT")+":")
	$VBox_GridSelection/HBoxContainer/BackButton.set_text(tr("DIFFICULTY"))
	$VBox_GridSelection/HBoxContainer/MainMenu.set_text(tr("MAIN_MENU"))
