extends PopupDialog


var original_background_colour
var original_sfx_on
var original_sfx_vol
var original_music_on 
var original_music_vol
var original_colour_blind_mode
var original_card_back
var new_background_colour
var new_sfx_on
var new_sfx_vol
var new_music_on 
var new_music_vol
var new_colour_blind_mode
var new_card_back

signal popup_submitted
signal popup_cancel


func _ready() -> void: 
	create_card_back_options_button() 


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
	original_card_back = PlayerData.get_card_back()
	print("original card back ", original_card_back)
	original_sfx_on = AudioManager.get_sfx_on()
	original_sfx_vol = AudioManager.get_sfx_vol()
	original_music_on = AudioManager.get_music_on()
	original_music_vol = AudioManager.get_music_vol()
	use_original_data()

func set_config_data() -> void: 
	PlayerData.set_background_colour(get_node("VBox_Options/GridContainer/ColorPickerButton").get_pick_color())
	PlayerData.set_colour_blind_mode_on(get_node("VBox_Options/GridContainer/ColourBLindChkBx").pressed)
	PlayerData.set_card_back(get_node("VBox_Options/GridContainer/CardBackOptionButton").get_selected_id())
	print("new card back ", PlayerData.get_card_back())
	AudioManager.set_sfx_on(get_node("VBox_Options/GridContainer/SfxOnChckbx").pressed)
	AudioManager.set_sfx_vol(get_node("VBox_Options/GridContainer/SfxVol_Slider").get_value())
	AudioManager.set_music_on(get_node("VBox_Options/GridContainer/MusicOnChckbx").pressed)
	AudioManager.set_music_vol(get_node("VBox_Options/GridContainer/MusicVol_Slider").get_value())
	AudioManager.check_music()
	Config.save_config()


func use_original_data() -> void:
	get_node("PopupBackground").set_frame_color(original_background_colour)
	get_node("VBox_Options/GridContainer/ColourBLindChkBx").pressed = original_colour_blind_mode
	get_node("VBox_Options/GridContainer/ColorPickerButton").set_pick_color(original_background_colour)
	get_node("VBox_Options/GridContainer/SfxOnChckbx").pressed = original_sfx_on
	get_node("VBox_Options/GridContainer/SfxVol_Slider").set_value(original_sfx_vol)
	get_node("VBox_Options/GridContainer/MusicOnChckbx").pressed = original_music_on
	get_node("VBox_Options/GridContainer/MusicVol_Slider").set_value(original_music_vol)
	get_node("VBox_Options/GridContainer/CardBackOptionButton").select(original_card_back)
	update_card_back_options_button(original_card_back)


func _on_ColorPickerButton_color_changed(color: Color) -> void:
	new_background_colour = get_node("VBox_Options/GridContainer/ColorPickerButton").get_pick_color()
	get_node("PopupBackground").set_frame_color(color)


func _on_SfxOnChckbx_toggled(button_pressed: bool) -> void:
	new_sfx_on = button_pressed
	AudioManager.set_sfx_on(new_sfx_on)
	if new_sfx_on:
		AudioManager.play_rand_sfx()


func _on_SfxVol_Slider_value_changed(value: float) -> void:
	AudioManager.set_sfx_vol(value)
	AudioManager.play_rand_sfx()


func _on_MusicOnChckbx_toggled(button_pressed: bool) -> void:
	new_music_on = button_pressed
	AudioManager.set_music_on(new_music_on)


func _on_MusicVol_Slider_value_changed(value: float) -> void:
	AudioManager.set_music_vol(value)


func _on_OptionsPopup_about_to_show() -> void:
	get_node("PopupBackground").set_frame_color(PlayerData.get_background_colour())
	ready_texts()
	get_config_data()
	


func _on_ColourBLindChkBx_toggled(button_pressed: bool) -> void:
	new_colour_blind_mode = button_pressed
	PlayerData.set_colour_blind_mode_on(new_colour_blind_mode)
	AudioManager.play_rand_sfx()


func _on_ResetButton_button_up() -> void:
	AudioManager.play_rand_sfx()
	PlayerData.reset_defaults()
	AudioManager.reset_defaults()
	Config.save_config()
	hide()


func ready_texts() -> void:
	# 14 entries of text  (all labels, plus on/off text for buttons)
	get_node("VBox_Options/Options").set_text(tr("OPTIONS"))
	get_node("VBox_Options/GridContainer/ColourBlindLabel").set_text(tr("COLOURBLIND_MODE")+":")
	get_node("VBox_Options/GridContainer/BckgrndColLabel").set_text(tr("BACKGROUND_COLOUR")+":")
	get_node("VBox_Options/GridContainer/SfxOn_Label").set_text(tr("SFX_ON")+":")
	get_node("VBox_Options/GridContainer/SfxVol_Label").set_text(tr("SFX_VOL")+":")
	get_node("VBox_Options/GridContainer/MusicOn_Label").set_text(tr("MUS_ON")+":")
	get_node("VBox_Options/GridContainer/MusicVol_Label").set_text(tr("MUS_VOL")+":")
	get_node("VBox_Options/GridContainer/CardBack_Label").set_text(tr("CARD_BACK_OPT")+":")
	get_node("VBox_Options/HBoxContainer/SubmitOptionsButton").set_text(tr("SUBMIT"))
	get_node("VBox_Options/HBoxContainer/CancelButton").set_text(tr("CANCEL"))
	get_node("VBox_Options/HBoxContainer/ResetButton").set_text(tr("RESET"))


func update_card_back_options_button(card_back_selection) -> void: 
	get_node("VBox_Options/GridContainer/CardBackOptionButton").select(card_back_selection)


func create_card_back_options_button() -> void: 
	var card_back_a = load("res://assets/images/card_backs/CardBack_A.png") # Godot loads the Resource when it reads the line.
	var card_back_b = load("res://assets/images/card_backs/CardBack_B.png") 
	var card_back_c = load("res://assets/images/card_backs/CardBack_C.png") 
	var card_back_d = load("res://assets/images/card_backs/CardBack_D.png") 
	get_node("VBox_Options/GridContainer/CardBackOptionButton").add_icon_item(card_back_a, "A", 0)
	get_node("VBox_Options/GridContainer/CardBackOptionButton").add_icon_item(card_back_b, "B", 1)
	get_node("VBox_Options/GridContainer/CardBackOptionButton").add_icon_item(card_back_c, "C", 2)
	get_node("VBox_Options/GridContainer/CardBackOptionButton").add_icon_item(card_back_d, "D", 3)


func _on_CardBackOptionButton_item_selected(index: int) -> void:
	new_card_back = index
	print("new card back index: ", new_card_back)
