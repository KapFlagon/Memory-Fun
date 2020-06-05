extends Control


func _ready() -> void:
	get_node("ColorRect").set_frame_color(PlayerData.get_background_colour())
	get_player_data()


func _on_SubmitOptionsButton_button_up() -> void:
	set_player_data()
	change_screen()


func _on_CancelButton_button_up() -> void:
	change_screen()


func change_screen() -> void: 
	get_tree().change_scene("res://src/screens/StartScreen.tscn")


func get_player_data() -> void:
	get_node("VBox_Options/GridContainer/ColorPickerButton").set_pick_color(PlayerData.get_background_colour())
	get_node("VBox_Options/GridContainer/SfxOnChckbx").pressed = PlayerData.get_sfx_on()
	get_node("VBox_Options/GridContainer/SfxVol_Slider").set_value(PlayerData.get_sfx_vol())
	get_node("VBox_Options/GridContainer/MusicOnChckbx").pressed = PlayerData.get_music_on()
	get_node("VBox_Options/GridContainer/MusicVol_Slider").set_value(PlayerData.get_music_vol())

func set_player_data() -> void: 
	PlayerData.set_background_colour(get_node("VBox_Options/GridContainer/ColorPickerButton").get_pick_color())
	PlayerData.set_sfx_on(get_node("VBox_Options/GridContainer/SfxOnChckbx").pressed)
	PlayerData.set_sfx_vol(get_node("VBox_Options/GridContainer/SfxVol_Slider").get_value())
	PlayerData.set_music_on(get_node("VBox_Options/GridContainer/MusicOnChckbx").pressed)
	PlayerData.set_music_vol(get_node("VBox_Options/GridContainer/MusicVol_Slider").get_value())
	PlayerData.check_music()
