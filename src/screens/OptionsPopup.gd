extends PopupDialog

var original_background_colour
var original_sfx_on
var original_sfx_vol
var original_music_on 
var original_music_vol
var original_colour_blind_mode
var new_background_colour
var new_sfx_on
var new_sfx_vol
var new_music_on 
var new_music_vol
var new_colour_blind_mode


signal popup_submitted
signal popup_cancel


#func _ready() -> void:
#	get_node("PopupBackground").set_frame_color(PlayerData.get_background_colour())
#	get_config_data()


func _on_SubmitOptionsButton_button_up() -> void:
	AudioManager.play_rand_sfx()
	set_config_data()
	hide()
	emit_signal("popup_submitted")


func _on_CancelButton_button_up() -> void:
	use_original_data()
	AudioManager.play_rand_sfx()
	hide()
	emit_signal("popup_cancel")


func get_config_data() -> void:
	original_background_colour = PlayerData.get_background_colour()
	original_colour_blind_mode = PlayerData.get_colour_blind_mode_on()
	original_sfx_on = AudioManager.get_sfx_on()
	original_sfx_vol = AudioManager.get_sfx_vol()
	original_music_on = AudioManager.get_music_on()
	original_music_vol = AudioManager.get_music_vol()
	use_original_data()

func set_config_data() -> void: 
	PlayerData.set_background_colour(get_node("VBox_Options/GridContainer/ColorPickerButton").get_pick_color())
	PlayerData.set_colour_blind_mode_on(get_node("VBox_Options/GridContainer/ColourBLindChkBx").pressed)
	AudioManager.set_sfx_on(get_node("VBox_Options/GridContainer/SfxOnChckbx").pressed)
	AudioManager.set_sfx_vol(get_node("VBox_Options/GridContainer/SfxVol_Slider").get_value())
	AudioManager.set_music_on(get_node("VBox_Options/GridContainer/MusicOnChckbx").pressed)
	AudioManager.set_music_vol(get_node("VBox_Options/GridContainer/MusicVol_Slider").get_value())
	AudioManager.check_music()


func use_original_data() -> void:
	get_node("PopupBackground").set_frame_color(original_background_colour)
	get_node("VBox_Options/GridContainer/ColourBLindChkBx").pressed = original_colour_blind_mode
	get_node("VBox_Options/GridContainer/ColorPickerButton").set_pick_color(original_background_colour)
	get_node("VBox_Options/GridContainer/SfxOnChckbx").pressed = original_sfx_on
	get_node("VBox_Options/GridContainer/SfxVol_Slider").set_value(original_sfx_vol)
	get_node("VBox_Options/GridContainer/MusicOnChckbx").pressed = original_music_on
	get_node("VBox_Options/GridContainer/MusicVol_Slider").set_value(original_music_vol)


func _on_ColorPickerButton_color_changed(color: Color) -> void:
	new_background_colour = get_node("VBox_Options/GridContainer/ColorPickerButton").get_pick_color()
	get_node("PopupBackground").set_frame_color(color)


func _on_SfxOnChckbx_toggled(button_pressed: bool) -> void:
	new_sfx_on = button_pressed
	AudioManager.set_sfx_on(new_sfx_on)


func _on_SfxVol_Slider_value_changed(value: float) -> void:
	AudioManager.set_sfx_vol(value)


func _on_MusicOnChckbx_toggled(button_pressed: bool) -> void:
	new_music_on = button_pressed
	AudioManager.set_music_on(new_music_on)


func _on_MusicVol_Slider_value_changed(value: float) -> void:
	AudioManager.set_music_vol(value)


func check_colour_blind_mode() -> void: 
	if PlayerData.get_colour_blind_mode_on(): 
		get_node("VBox_Options/GridContainer/ColorPickerButton").disabled = true
	else: 
		get_node("VBox_Options/GridContainer/ColorPickerButton").disabled = false


func _on_OptionsPopup_about_to_show() -> void:
	get_node("PopupBackground").set_frame_color(PlayerData.get_background_colour())
	get_config_data()
	check_colour_blind_mode()


func _on_ColourBLindChkBx_toggled(button_pressed: bool) -> void:
	new_colour_blind_mode = button_pressed
	PlayerData.set_colour_blind_mode_on(new_colour_blind_mode)
	if new_colour_blind_mode:
		get_node("PopupBackground").set_frame_color(PlayerData.get_background_colour())
		get_node("VBox_Options/GridContainer/ColorPickerButton").set_pick_color(PlayerData.get_background_colour())
	else:
		if new_background_colour == null:
			get_node("PopupBackground").set_frame_color(PlayerData.get_background_colour())
			get_node("VBox_Options/GridContainer/ColorPickerButton").set_pick_color(PlayerData.get_background_colour())
		else: 
			get_node("PopupBackground").set_frame_color(new_background_colour)
			get_node("VBox_Options/GridContainer/ColorPickerButton").set_pick_color(new_background_colour)
