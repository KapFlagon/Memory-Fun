extends Control


func _ready() -> void:
	AudioManager.play_victory_sound()
	get_node("ColorRect").set_frame_color(PlayerData.get_background_colour())
	$VBox/HBoxContainer/StatText.set_text(PlayerData.get_game_time_str())
	ready_texts()
	get_node("Popup_NameEntry").popup()
	
func _process(delta: float) -> void:
	process_inputs()


func _on_PlayAgainButton_button_up() -> void:
	AudioManager.play_rand_sfx()
	get_tree().change_scene("res://src/screens/GameScreen.tscn")


func _on_NewVariants_button_up() -> void:
	AudioManager.play_rand_sfx()
	get_tree().change_scene("res://src/screens/DifficultySelectionScreen.tscn")


func _on_MainMenuButton_button_up() -> void:
	AudioManager.play_rand_sfx()
	get_tree().change_scene("res://src/screens/StartScreen.tscn")


func _on_SubmitButton_button_up() -> void:
	AudioManager.play_rand_sfx()
	# Save score and name via score manager
	var name = get_node("Popup_NameEntry/VBoxContainer/LineEdit").get_text()
	var score = PlayerData.get_game_time_secs()
	ScoreManager.new_score(name, score, PlayerData.get_difficulty(), PlayerData.get_grid_size())
	get_node("Popup_NameEntry").hide()
	pass # Replace with function body.


func _on_OptionsButton_popup_hidden() -> void:
	get_node("ColorRect").set_frame_color(PlayerData.get_background_colour())


func process_inputs() -> void:
	if get_node("Popup_NameEntry").visible == true:
		if Input.is_action_just_pressed("ui_accept"):
			_on_SubmitButton_button_up()


func ready_texts() -> void:
	$VBox/GameOverText.set_text(tr("GAME_OVER"))
	$VBox/HBoxContainer/StatPrompt.set_text(tr("TIMER_TEXT"))
	$VBox/PlayAgainButton.set_text(tr("PLAY_AGAIN"))
	$VBox/NewVariants.set_text(tr("CHANGE_SETTINGS"))
	$VBox/OptionsButton.set_text(tr("OPTIONS"))
	$VBox/MainMenuButton.set_text(tr("MAIN_MENU"))
	$Popup_NameEntry/VBoxContainer/Prompt.set_text(tr("NAME_PROMPT"))
	$Popup_NameEntry/VBoxContainer/LineEdit.set_placeholder(tr("NAME_PLACEHOLDER"))
	$Popup_NameEntry/VBoxContainer/SubmitButton.set_text(tr("SUBMIT"))
