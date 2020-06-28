extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("ColorRect").set_frame_color(PlayerData.get_background_colour())
	ready_texts()
	if AudioManager.initialized == false:
		AudioManager.check_music()
		AudioManager.initialized = true


func _on_CreditsButton_button_up() -> void:
	get_tree().change_scene("res://src/screens/CreditsScreen.tscn")
	AudioManager.play_rand_sfx()


func _on_CheckBox_toggled(button_pressed: bool) -> void:
	PlayerData.set_colour_blind_mode_on(button_pressed)
	Config.save_config()
	AudioManager.play_rand_sfx()


func _on_HowToPlayButton_button_up() -> void:
	get_tree().change_scene("res://src/screens/HowToPlayScreen.tscn")
	AudioManager.play_rand_sfx()


func _on_HighScoreButton_button_up() -> void:
	get_tree().change_scene("res://src/screens/HighScoreScreen.tscn")
	AudioManager.play_rand_sfx()


func _on_OptionsButton_popup_hidden() -> void:
	get_node("ColorRect").set_frame_color(PlayerData.get_background_colour())
	get_node("VBox_MainMenu/HBoxContainer/ColourBlindCheckBox").pressed = PlayerData.get_colour_blind_mode_on()


func ready_texts() -> void: 
	get_node("VBox_MainMenu/StartButton").set_text(tr("START"))
	get_node("VBox_MainMenu/OptionsButton").set_text(tr("OPTIONS"))
	get_node("VBox_MainMenu/HowToPlayButton").set_text(tr("HOW_TO_PLAY"))
	get_node("VBox_MainMenu/HighScoreButton").set_text(tr("HIGH_SCORES"))
	get_node("VBox_MainMenu/CreditsButton").set_text(tr("CREDITS"))
	get_node("VBox_MainMenu/HBoxContainer/ColourBlindCheckBox").set_text(tr("COLOURBLIND_MODE"))
