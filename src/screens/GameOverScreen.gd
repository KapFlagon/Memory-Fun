extends Control


func _ready() -> void:
	AudioManager.play_victory_sound()
	get_node("ColorRect").set_frame_color(PlayerData.get_background_colour())
	$VBox/HBoxContainer/StatText.set_text(PlayerData.get_game_time_str())
	get_node("Popup_NameEntry").popup()


func _on_PlayAgainButton_button_up() -> void:
	AudioManager.play_rand_sfx()
	get_tree().change_scene("res://src/screens/GameScreen.tscn")


func _on_NewVariants_button_up() -> void:
	AudioManager.play_rand_sfx()
	get_tree().change_scene("res://src/screens/DifficultySelectionScreen.tscn")


func _on_OptionsButton_options_submitted() -> void:
	get_node("ColorRect").set_frame_color(PlayerData.get_background_colour())


func _on_MainMenuButton_button_up() -> void:
	get_tree().change_scene("res://src/screens/StartScreen.tscn")


func _on_SubmitButton_button_up() -> void:
	# Save score and name via score manager
	get_node("Popup_NameEntry").hide()
	pass # Replace with function body.
