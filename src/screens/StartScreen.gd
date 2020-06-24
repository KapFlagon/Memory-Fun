extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("ColorRect").set_frame_color(PlayerData.get_background_colour())
	if AudioManager.initialized == false:
		AudioManager.check_music()
		AudioManager.initialized = true


func _on_OptionsButton_options_submitted() -> void:
	get_node("ColorRect").set_frame_color(PlayerData.get_background_colour())


func _on_CreditsButton_button_up() -> void:
	get_tree().change_scene("res://src/screens/CreditsScreen.tscn")


func _on_CheckBox_toggled(button_pressed: bool) -> void:
	PlayerData.set_colour_blind_mode_on(button_pressed)
	Config.save_config()
	var sfx_on = AudioManager.get_sfx_on()
	if sfx_on:
		AudioManager.play_rand_sfx()


func _on_HowToPlayButton_button_up() -> void:
	get_tree().change_scene("res://src/screens/HowToPlayScreen.tscn")


func _on_HighScoreButton_button_up() -> void:
	get_tree().change_scene("res://src/screens/HighScoreScreen.tscn")
